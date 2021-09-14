CLASS zc_insert_data DEFINITION
PUBLIC
FINAL
CREATE PUBLIC .



PUBLIC SECTION.



INTERFACES if_oo_adt_classrun .
METHODS add_user_data.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.





CLASS zc_insert_data IMPLEMENTATION.



METHOD add_user_data.



data bustab1 type STANDARD TABLE OF ztravel_g4.

bustab1 = VALUE #(
( travel_uuid = '0000000000000003' bus_id = '2' start_date = '21121221' )
).




insert ztravel_g4 from table @bustab1.
ENDMETHOD.



METHOD if_oo_adt_classrun~main.
*add_user_data(  ).
*out->write( 'Hey' ).
*    READ ENTITIES OF ZI_BUS_G4
*          ENTITY Bus
*            ALL FIELDS
*                WITH CORRESPONDING #(  )
*            RESULT DATA(travels).
*     SELECT COUNT( * ) FROM ztravel_g4
*     WHERE bus_id = '2' AND start_date = '21121221'
*     INTO @DATA(travel).

SELECT COUNT( * ) FROM ztravel_g4
        INTO @DATA(count_total_rows).
    out->write( count_total_rows ).

*    DELETE From zbooking_g4.
*out->write( 'Data inserted' ).
ENDMETHOD.
ENDCLASS.
