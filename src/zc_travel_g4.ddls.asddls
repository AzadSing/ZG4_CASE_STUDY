@EndUserText.label: 'Travel Data Projection'
@AccessControl.authorizationCheck: #CHECK
//@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_Travel_G4 as projection on ZI_TRAVEL_G4 {
    key TravelUuid,
    TravelId,
    BusUuid,
    BusId,
    StartDate,
    EmptySeats,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Bus
    
}
