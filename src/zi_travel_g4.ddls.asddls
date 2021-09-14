@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Homepage'
define root view entity ZI_TRAVEL_G4 as select from ztravel_g4
association [1..1] to ZI_BUS_G4 as _Bus on $projection.BusUuid = _Bus.BusUuid
{
    key ztravel_g4.travel_uuid as TravelUuid,
    ztravel_g4.travel_id as TravelId,
    ztravel_g4.bus_uuid as BusUuid,
    ztravel_g4.bus_id as BusId,
    ztravel_g4.start_date as StartDate,
    ztravel_g4.empty_seats as EmptySeats,
    ztravel_g4.last_changed_at as LastChangedAt,
    ztravel_g4.local_last_changed_at as LocalLastChangedAt,
    /* association */
    _Bus
    
    
}
