@EndUserText.label: 'Bus Detail Data Projection'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_Bus_g4 as projection on ZI_BUS_G4 {
    key BusUuid,
    BusId,
    BusName,
    @Search.defaultSearchElement: true
    Source,
    @Search.defaultSearchElement: true
    Destination,
    Fare,
    TotalSeats,
    DepartureTime,
    Duration,
    LastChangedAt,
    LocalLastChangedAt
    
}
