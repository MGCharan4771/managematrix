using my.matrix as my from '../db/schema';

service CatalogService {
    entity CommMatrixList   as projection on my.CommMatrixList;
    entity commission       as projection on my.commission;
    entity CompanyCodeVH    as projection on my.CompanyCodeVH;
    entity BusinessEntityVH as projection on my.BusinessEntityVH;
    entity BuildingVH       as projection on my.BuildingVH;
    entity LandVH           as projection on my.LandVH;
    entity ContractTypeVH   as projection on my.ContractTypeVH;
    entity RoleVH           as projection on my.RoleVH;
}
