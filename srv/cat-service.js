const cds = require('@sap/cds');

class service extends cds.ApplicationService {
    async init() {
        const { commission } = this.entities;
        this.before('CREATE', 'CommMatrixList', async (req) => {
            console.log(req);
            const db = await cds.connect.to('db');
            let commInfo = await db.run(SELECT.from(`CatalogService.CommMatrixList`).where({
                companycode: req.data.companycode,
                project: req.data.project,
                building: req.data.building,
                land: req.data.land,
                salesgroup: req.data.salesgroup
            }));
            console.log(commInfo);
            for (var j = 0; j < commInfo.length; j++) {
                if (commInfo[j].validTo >= req.data.validFrom) {
                    req.error({
                        code: "INPUT_REQUIRED",
                        status: 400,
                        message: `Validity Period already available for Selected data`
                    })
                    break;
                }
            }
            if (req.data.validFrom > req.data.validTo) {
                req.error({
                    code: "INPUT_REQUIRED",
                    status: 400,
                    message: `Valid From Should not be greater than Valid To`
                })
            }
            if ((req.data.building == null || req.data.building == '') && (req.data.land == null || req.data.land == '')) {
                req.error({
                    code: "INPUT_REQUIRED",
                    status: 400,
                    message: `Fill in either Building or Land`
                })
            } else if ((req.data.building != null && req.data.building != '') && (req.data.land != null && req.data.land != '')) {
                req.error({
                    code: "INPUT_REQUIRED",
                    status: 400,
                    message: `Fill only either Building or Land`
                })
            }
            for (var j = 0; j < req.data.lineitem.length; j++) {
                var record = req.data.lineitem;
                if ((record[j].commissionrate == null || record[j].commissionrate == '') && (record[j].months == null || record[j].months == '')) {
                    req.error({
                        code: "INPUT_REQUIRED",
                        status: 400,
                        message: `Fill in either Commission Rate or Months`
                    })
                } else if ((record[j].commissionrate != null && record[j].commissionrate != '') && (record[j].months != null && record[j].months != '')) {
                    req.error({
                        code: "INPUT_REQUIRED",
                        status: 400,
                        message: `Fill in either Commission Rate or Months`
                    })
                }
            }
        }),
            this.before('UPDATE', 'CommMatrixList', async (req) => {
                const db = await cds.connect.to('db');

                let commInfo = await db.run(SELECT.from(`CatalogService.CommMatrixList`).where({
                    companycode: req.data.companycode,
                    project: req.data.project,
                    building: req.data.building,
                    land: req.data.land,
                    salesgroup: req.data.salesgroup
                }));
                console.log(commInfo);
                for (var j = 0; j < commInfo.length; j++) {
                    if (commInfo[j].validFrom != req.data.validFrom && commInfo[j].validTo != req.data.validTo) {
                        if (commInfo[j].validTo >= req.data.validFrom) {
                            req.error({
                                code: "INPUT_REQUIRED",
                                status: 400,
                                message: `Validity Period already available for Selected data`
                            })
                            break;
                        }
                    }
                }
                if (req.data.validFrom > req.data.validTo) {
                    req.error({
                        code: "INPUT_REQUIRED",
                        status: 400,
                        message: `Valid From Should not be greater than Valid To`
                    })
                }
                if ((req.data.building == null || req.data.building == '') && (req.data.land == null || req.data.land == '')) {
                    req.error({
                        code: "INPUT_REQUIRED",
                        status: 400,
                        message: `Fill in either Building or Land`
                    })
                } else if ((req.data.building != null && req.data.building != '') && (req.data.land != null && req.data.land != '')) {
                    req.error({
                        code: "INPUT_REQUIRED",
                        status: 400,
                        message: `Fill only either Building or Land`
                    })
                }
            }),
            this.on('go', 'CommMatrixList.drafts', async (req) => {
                const db = await cds.connect.to('db');
                let dataInfo = await db.run(SELECT.from(`CatalogService.CommMatrixList.drafts`).where({ ID: req.params[0].ID }));

                if ((dataInfo[0].building == null || dataInfo[0].building == '') && (dataInfo[0].land == null || dataInfo[0].land == '')) {
                    req.error({
                        code: "INPUT_REQUIRED",
                        status: 400,
                        message: `Fill in either Building or Land`
                    })
                } else if ((dataInfo[0].building != null && dataInfo[0].building != '') && (dataInfo[0].land != null && dataInfo[0].land != '')) {
                    req.error({
                        code: "INPUT_REQUIRED",
                        status: 400,
                        message: `Fill only either Building or Land`
                    })
                } else {
                    let commInfo = await db.run(SELECT.from(`CatalogService.CommMatrixList`).where({
                        companycode: dataInfo[0].companycode,
                        project: dataInfo[0].project,
                        building: dataInfo[0].building,
                        land: dataInfo[0].land,
                        validFrom: dataInfo[0].validFrom,
                        validTo: dataInfo[0].validTo
                    }))
                    console.log(commInfo)
                    if (commInfo && commInfo.length > 0) {
                        let commissionInfo = await db.run(SELECT.from(`CatalogService.commission`).where({ parent_ID: commInfo[0].ID }));
                        let downpaymetData = await db.run(SELECT.from(commission.drafts).where({ parent_ID: dataInfo[0].ID }));
                        if (downpaymetData && downpaymetData.length > 0)
                            await db.run(DELETE.from(commission.drafts).where({ parent_ID: dataInfo[0].ID }));

                        for (var i = 0; i < commissionInfo.length; i++) {
                            let payload = {
                                "parent_ID": dataInfo[0].ID,
                                "contractType_REContractType": commissionInfo[i].contractType_REContractType,
                                "role_BusinessPartnerRole": commissionInfo[i].role_BusinessPartnerRole,
                                "commissionrate": commissionInfo[i].commissionrate,
                                "months": commissionInfo[0].months,
                                "DraftAdministrativeData_DraftUUID": dataInfo[0].DraftAdministrativeData_DraftUUID
                            }
                            let insRes = await cds.transaction(req).run(INSERT.into(commission.drafts).entries(payload));
                        }
                    }
                }
                console.log(req)
            }),
            this.on('copy', 'commission.drafts', async (req) => {
                console.log(req)
                let ID = req.params[1].ID;
                const db = await cds.connect.to('db');
                let dataInfo = await db.run(SELECT.from(`CatalogService.commission.drafts`).where({ ID: req.params[1].ID }));
                let payload = {
                    "parent_ID": req.params[0].ID,
                    "contractType_REContractType": dataInfo[0].contractType_REContractType,
                    "role_BusinessPartnerRole": dataInfo[0].role_BusinessPartnerRole,
                    "commissionrate": dataInfo[0].commissionrate,
                    "months": dataInfo[0].months,
                    "DraftAdministrativeData_DraftUUID": dataInfo[0].DraftAdministrativeData_DraftUUID
                }
                let insRes = await cds.transaction(req).run(INSERT.into(commission.drafts).entries(payload));
            })
        await super.init()
    }

};
module.exports = service;