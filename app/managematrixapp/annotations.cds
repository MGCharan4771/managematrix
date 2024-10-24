using CatalogService as service from '../../srv/cat-service';
annotate service.CommMatrixList with @(
    UI.SelectionFields : [
        companycode,
        project,
        building,
        land,
        validFrom,
        validTo,
        salesgroup,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : companycodeText,
            Label : '{i18n>CompanyCodeDescription}',
        },
        {
            $Type : 'UI.DataField',
            Value : projectText,
            Label : '{i18n>BusinessEntityDescription}',
        },
        {
            $Type : 'UI.DataField',
            Value : buildingText,
            Label : '{i18n>BuildingDescription}',
        },
        {
            $Type : 'UI.DataField',
            Value : landText,
            Label : '{i18n>LandDescription}',
        },
        {
            $Type : 'UI.DataField',
            Value : validFrom,
            Label : '{i18n>ValidFrom}',
        },
        {
            $Type : 'UI.DataField',
            Value : validTo,
            Label : '{i18n>ValidTo}',
        },
        {
            $Type : 'UI.DataField',
            Value : salesgroup,
            Label : '{i18n>Version}',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>GeneralInformation}',
            ID : 'i18nGeneralInformation',
            Target : '@UI.FieldGroup#i18nGeneralInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>LineItems}',
            ID : 'i18nLineItems',
            Target : 'lineitem/@UI.LineItem#i18nLineItems',
        },
    ],
    UI.FieldGroup #i18nGeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : companycode,
                Label : '{i18n>CompanyCode}',
            },
            {
                $Type : 'UI.DataField',
                Value : companycodeText,
                Label : '{i18n>CompanyCodeDescription}',
            },
            {
                $Type : 'UI.DataField',
                Value : project,
                Label : '{i18n>BusinessEntity}',
            },
            {
                $Type : 'UI.DataField',
                Value : projectText,
                Label : '{i18n>BusinessEntityDescription}',
            },
            {
                $Type : 'UI.DataField',
                Value : building,
                Label : '{i18n>Building}',
            },
            {
                $Type : 'UI.DataField',
                Value : buildingText,
                Label : '{i18n>BuildingDescription}',
            },
            {
                $Type : 'UI.DataField',
                Value : land,
                Label : '{i18n>Landproperty}',
            },
            {
                $Type : 'UI.DataField',
                Value : landText,
                Label : '{i18n>LandDescription}',
            },
            {
                $Type : 'UI.DataField',
                Value : validFrom,
                Label : '{i18n>ValidFrom}',
            },
            {
                $Type : 'UI.DataField',
                Value : validTo,
                Label : '{i18n>ValidTo}',
            },
            {
                $Type : 'UI.DataField',
                Value : salesgroup,
                Label : '{i18n>SalesGroup}',
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : 'Manage Commission Rates',
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

annotate service.CommMatrixList with {
    companycode @(
        Common.Label : '{i18n>CompanyCode}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'CompanyCodeVH',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : companycode,
                    ValueListProperty : 'companycode',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    ValueListProperty : 'companycodeText',
                    LocalDataProperty : companycodeText,
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : companycodeText,
    )
};

annotate service.CommMatrixList with {
    project @(
        Common.Label : '{i18n>BusinessEntity}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'BusinessEntityVH',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : project,
                    ValueListProperty : 'project',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    ValueListProperty : 'projectText',
                    LocalDataProperty : projectText,
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    ValueListProperty : 'companycode',
                    LocalDataProperty : companycode,
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : projectText,
    )
};

annotate service.CommMatrixList with {
    building @(
        Common.Label : '{i18n>Building}',
        Common.Text : buildingText,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'BuildingVH',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : building,
                    ValueListProperty : 'building',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    ValueListProperty : 'buildingText',
                    LocalDataProperty : buildingText,
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    ValueListProperty : 'companycode',
                    LocalDataProperty : companycode,
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    ValueListProperty : 'project',
                    LocalDataProperty : project,
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.CommMatrixList with {
    land @(
        Common.Label : '{i18n>Landproperty}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'LandVH',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : land,
                    ValueListProperty : 'land',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    ValueListProperty : 'landText',
                    LocalDataProperty : landText,
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    ValueListProperty : 'companycode',
                    LocalDataProperty : companycode,
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    ValueListProperty : 'project',
                    LocalDataProperty : project,
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.CommMatrixList with {
    validFrom @Common.Label : '{i18n>ValidFrom}'
};

annotate service.CommMatrixList with {
    validTo @Common.Label : '{i18n>ValidTo}'
};

annotate service.CommMatrixList with {
    salesgroup @Common.Label : 'Sales Group'
};

annotate service.commission with @(
    UI.LineItem #i18nLineItems : [
        {
            $Type : 'UI.DataField',
            Value : contractType,
            Label : '{i18n>Contracttype}',
        },
        {
            $Type : 'UI.DataField',
            Value : contractTypeText,
            Label : '{i18n>ContractTypeDescription}',
        },
        {
            $Type : 'UI.DataField',
            Value : role,
            Label : '{i18n>Role}',
        },
        {
            $Type : 'UI.DataField',
            Value : roleText,
            Label : '{i18n>RoleDescription}',
        },
        {
            $Type : 'UI.DataField',
            Value : commissionrate,
            Label : '{i18n>Commissionrate}',
        },
        {
            $Type : 'UI.DataField',
            Value : months,
            Label : '{i18n>Months}',
        },
    ]
);

annotate service.commission with {
    contractType @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'ContractTypeVH',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : contractType,
                    ValueListProperty : 'contractType',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    ValueListProperty : 'contractTypeText',
                    LocalDataProperty : contractTypeText,
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : contractTypeText,
)};

annotate service.commission with {
    role @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'RoleVH',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : role,
                    ValueListProperty : 'role',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    ValueListProperty : 'roleText',
                    LocalDataProperty : roleText,
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : roleText,
)};

