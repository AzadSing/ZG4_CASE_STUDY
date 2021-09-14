CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.


    METHODS changeBusStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~changeBusStatus.

    METHODS changeTravel FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~changeTravel.

    METHODS validateAge FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~validateAge.
    METHODS changeOnCreate FOR DETERMINE ON SAVE
      IMPORTING keys FOR Booking~changeOnCreate.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD changeBusStatus.
    READ ENTITIES OF zi_booking_g4 IN LOCAL MODE
      ENTITY Booking
        FIELDS ( BusId ) WITH CORRESPONDING #( keys )
      RESULT DATA(bookings).

    LOOP AT bookings INTO DATA(booking).

      SELECT SINGLE * FROM zbus_g4
      WHERE bus_id = @booking-BusId
      INTO @DATA(bus).

      MODIFY ENTITIES OF zi_booking_g4 IN LOCAL MODE
          ENTITY Booking
            UPDATE
              FIELDS ( BusName Source Destination DepartureTime Duration Fare )
              WITH VALUE #(
                            ( %tky         = booking-%tky
                              BusName = bus-bus_name
                              Source = bus-source
                              Destination = bus-destination
                              DepartureTime = bus-departure_time
                              Duration = bus-duration
                              Fare = bus-fare
                              ) ).
    ENDLOOP.

  ENDMETHOD.





  METHOD changeTravel.
    READ ENTITIES OF zi_booking_g4 IN LOCAL MODE
      ENTITY Booking
        FIELDS ( BusId StartDate ) WITH CORRESPONDING #( keys )
      RESULT DATA(travels).
    LOOP AT travels INTO DATA(travel).
      SELECT COUNT( * ) FROM ztravel_g4
      WHERE bus_id = @travel-BusId AND start_date = @travel-StartDate
      INTO @DATA(count_rows).
      IF count_rows > 0.
        SELECT SINGLE * FROM ztravel_g4
        WHERE bus_id = @travel-BusId AND start_date = @travel-StartDate
        INTO @DATA(travel_data).

        IF travel_data-empty_seats > 0.
            MODIFY ENTITIES OF zi_booking_g4 IN LOCAL MODE
              ENTITY Booking
                UPDATE
                  FIELDS ( TravelUuid CurrentStatus TravelId )
                  WITH VALUE #(
                                ( %tky         = travel-%tky
                                  TravelUuid = travel_data-travel_uuid
                                  CurrentStatus = 'Available'
                                  TravelId = travel_data-travel_id
                                  ) ).
        ENDIF.
        ELSE.
            DATA attr2 type STRING.
            DATA attr1 type STRING VALUE 'WL'.
            DATA cur_status type STRING.
            attr2 = ( ABS( travel_data-empty_seats - 1 ) ).
            concatenate attr1 attr2 into cur_status separated by space.
            MODIFY ENTITIES OF zi_booking_g4 IN LOCAL MODE
              ENTITY Booking
                UPDATE
                  FIELDS ( TravelUuid CurrentStatus TravelId )
                  WITH VALUE #(
                                ( %tky         = travel-%tky
                                  TravelUuid = travel_data-travel_uuid
                                  CurrentStatus = cur_status
                                  TravelId = travel_data-travel_id
                                  ) ).
        .
      ENDIF.
      IF count_rows = 0.
        SELECT COUNT( * ) FROM ztravel_g4
        INTO @DATA(count_total_rows).

        SELECT SINGLE * FROM zbus_g4
        WHERE bus_id = @travel-BusId
        INTO @DATA(bus_data).
        attr1 = ( count_total_rows + 1 ).
        MODIFY ENTITIES OF zi_travel_g4
          ENTITY Travel
            CREATE
              SET FIELDS WITH VALUE
                #( ( %cid        = 'MyContentID_1'
                     BusUuid = bus_data-bus_uuid
                     TravelId = attr1
                     BusId = travel-BusId
                     StartDate = travel-StartDate
                     EmptySeats = bus_data-total_seats
                     ) ).

        SELECT SINGLE * FROM ztravel_g4
        WHERE bus_id = @travel-BusId AND start_date = @travel-StartDate
        INTO @DATA(travel_new_data).
*        DATA attr2 type STRING.
*            DATA attr1 type STRING VALUE 'WL'.
*            DATA cur_status type STRING.
*            attr2 = ( ABS( travel_data-empty_seats - 1 ) ).
*            concatenate attr1 attr2 into cur_status separated by cl_abap_char_utilities=>cr_lf.

        MODIFY ENTITIES OF zi_booking_g4 IN LOCAL MODE
              ENTITY Booking
                UPDATE
                  FIELDS ( TravelUuid CurrentStatus TravelId )
                  WITH VALUE #(
                                ( %tky         = travel-%tky
                                  TravelUuid = travel_new_data-travel_uuid
                                  CurrentStatus = 'Available'
                                  TravelId = travel_new_data-travel_id
                                  ) ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.



  METHOD validateAge.
    READ ENTITIES OF zi_booking_g4 IN LOCAL MODE
      ENTITY Booking
        FIELDS ( PassangerAge ) WITH CORRESPONDING #( keys )
      RESULT DATA(passangers).

    LOOP AT passangers INTO DATA(passanger).

      IF passanger-PassangerAge > 120.

        APPEND VALUE #( %tky = passanger-%tky ) TO failed-Booking.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.







  METHOD changeOnCreate.
    SELECT COUNT( * ) FROM zbooking_g4
    INTO @DATA(count_total_rows).
    DATA attr1 TYPE STRING.
    attr1 = ( count_total_rows + 1 ).
    MODIFY ENTITIES OF zi_booking_g4 IN LOCAL MODE
              ENTITY Booking
                UPDATE
                  FIELDS ( Pnr )
                  WITH VALUE #( FOR key in keys
                                ( %tky = key-%tky
                                  Pnr = attr1 ) ).
  ENDMETHOD.

ENDCLASS.
