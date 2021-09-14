@EndUserText.label: 'Booking Projection view'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_Booking_G4 as projection on ZI_BOOKING_G4 as Booking{
    @EndUserText.label: 'Booking UUID'
    key BookingUuid,
    @EndUserText.label: 'PNR ID'
    @Consumption.valueHelpDefinition: [{ entity: {name : 'ZI_BOOKING_G4', element: 'Pnr'}}]
    @Search.defaultSearchElement: true
    Pnr,
    TravelUuid,
    @EndUserText.label: 'Booking Date'
    BookingDate,
    @EndUserText.label: 'Current Status'
    CurrentStatus,
    @EndUserText.label: 'Gender'
    Gender,
    @EndUserText.label: 'Passanger Name'
    @Consumption.valueHelpDefinition: [{ entity: {name : 'ZI_BOOKING_G4', element: 'PassangerName'}}]
    @Search.defaultSearchElement: true
    PassangerName,
    @EndUserText.label: 'Passenger Age'
    PassangerAge,
    @EndUserText.label: 'Phone Number'
    PhoneNumber,
    @EndUserText.label: 'User ID'
    UserId,
    @EndUserText.label: 'Travel ID'
    @Consumption.valueHelpDefinition: [{ entity: {name : 'ZI_BOOKING_G4', element: 'TravelId'}}]
    @Search.defaultSearchElement: true
    TravelId,
    @EndUserText.label: 'Bus ID'
    @Consumption.valueHelpDefinition: [{ entity: {name : 'ZI_BUS_G4', element: 'BusId'}}]
    @Search.defaultSearchElement: true
    @ObjectModel.text.element: ['BusName'] 
    BusId,
    @EndUserText.label: 'Start Date'
    @Consumption.valueHelpDefinition: [{ entity: {name : 'ZI_TRAVEL_G4', element: 'StartDate'}}]
    @Search.defaultSearchElement: true
    StartDate,
    @EndUserText.label: 'Available Seats'
    EmptySeats,
    @EndUserText.label: 'Bus Name'
    BusName,
    @EndUserText.label: 'Departure Time'
    DepartureTime,
    @EndUserText.label: 'Travel Duration'
    Duration,
    @EndUserText.label: 'Source'
    @Consumption.valueHelpDefinition: [{ entity: {name : 'ZI_BUS_G4', element: 'Source'}}]
    @Search.defaultSearchElement: true
    Source,
    @EndUserText.label: 'Destination'
    @Consumption.valueHelpDefinition: [{ entity: {name : 'ZI_BUS_G4', element: 'Destination'}}]
    @Search.defaultSearchElement: true
    Destination,
    @EndUserText.label: 'Fare'
    Fare,
    @EndUserText.label: 'Total Seats'
    TotalSeats,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Travel
    
    
}
