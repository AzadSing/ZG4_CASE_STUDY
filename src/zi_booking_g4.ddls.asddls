@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Homepage'
define root view entity ZI_BOOKING_G4 as select from zbooking_g4
association [1..1] to ZI_TRAVEL_G4 as _Travel on $projection.TravelUuid = _Travel.TravelUuid
{
    key zbooking_g4.booking_uuid as BookingUuid,
    zbooking_g4.pnr as Pnr,
    zbooking_g4.travel_uuid as TravelUuid,
    zbooking_g4.booking_date as BookingDate,
    zbooking_g4.current_status as CurrentStatus,
    zbooking_g4.gender as Gender,
    zbooking_g4.passanger_name as PassangerName,
    zbooking_g4.passanger_age as PassangerAge,
    zbooking_g4.phone_number as PhoneNumber,
    zbooking_g4.user_id as UserId,
    zbooking_g4.travel_id as TravelId,
    zbooking_g4.bus_id as BusId,
    zbooking_g4.start_date as StartDate,
    zbooking_g4.empty_seats as EmptySeats,
    zbooking_g4.bus_name as BusName,
    zbooking_g4.departure_time as DepartureTime,
    zbooking_g4.duration as Duration,
    zbooking_g4.source as Source,
    zbooking_g4.destination as Destination,
    zbooking_g4.fare as Fare,
    zbooking_g4.total_seats as TotalSeats,
    zbooking_g4.last_changed_at as LastChangedAt,
    zbooking_g4.local_last_changed_at as LocalLastChangedAt,
    /* association */
    _Travel
  
 
  
}
