namespace my.matrix;

@odata.draft.enabled
entity CommMatrixList {
  key ID              : UUID;
      companycode     : String  @mandatory  @Common.Label: 'Company Code';
      companycodeText : String  @Common.Label: 'Company Code Description';
      project         : String  @mandatory  @Common.Label: 'Business Entity';
      projectText     : String  @Common.Label: 'Business Entity Description';
      building        : String  @Common.Label: 'Building';
      buildingText    : String  @Common.Label: 'Building Description';
      land            : String  @Common.Label: 'Land/Property';
      landText        : String  @Common.Label: 'Land Description';
      validFrom       : Date    @mandatory  @Common.Label: 'Valid From';
      validTo         : Date    @mandatory  @Common.Label: 'Valid To';
      salesgroup         : String  @Common.Label: 'Sales Group';
      lineitem        : Composition of many commission
                          on lineitem.parent = $self;
}

entity commission {
  key ID               : UUID;
  key parent           : Association to CommMatrixList;
      contractType     : String @mandatory;
      contractTypeText : String @Common.Label: 'Contract Type Description';
      role             : String;
      roleText         : String @Common.Label: 'Role Description';
      commissionrate   : Decimal(5, 2);
      months           : String;
}

entity CompanyCodeVH {
  key companycode     : String;
      companycodeText : String;
}

entity BusinessEntityVH {
  key project     : String;
      companycode : String;
      projectText : String;
}

entity BuildingVH {
  key building     : String;
      companycode  : String;
      project      : String;
      buildingText : String;
}

entity LandVH {
  key land        : String;
      companycode : String;
      project     : String;
      landText    : String;
}

entity ContractTypeVH {
  key contractType     : String;
      contractTypeText : String;
}

entity RoleVH {
  key role     : String;
      roleText : String;
}
