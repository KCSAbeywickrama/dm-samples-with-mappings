
function transform(Input input) returns Output => {
    dtos: [
        {
            data: {
                MessageContent: {
                    AdditionalDataElements: null,
                    HeaderInformation: {
                        CreateDateUtc: input.Content.HeaderInformation.CreateDateUtc
                    },
                    TripInformation: {
                        AdditionalDataElements: null,
                        Assets: from var AssetsItem in input.Assets
                            where AssetsItem.Type == 1
                            select {
                                Type: AssetsItem.Type,
                                Id: AssetsItem.Id,
                                Confirmed: AssetsItem.Confirmed ?: false
                            },
                        OrderHeader: input.Content.TripInformation.OrderHeader ?: 0.0,
                        Stop: input.Content.TripInformation.Stop ?: 0.0,
                        Leg: input.Content.TripInformation.Leg ?: 0.0,
                        Move: input.Content.TripInformation.Move ?: 0,
                        TripName: input.Content.TripInformation.TripName ?: ""
                    },
                    EditByUser: null,
                    EditDateTime: input.Content.EditDateTime,
                    Malfunctions: null,
                    Odometer: null,
                    GpsPosition: null,
                    HosRuleSet: null,
                    Comments: null,
                    EventDate: input.Content.EditDateTime,
                    EventCode: input.Content.EventCode,
                    EventType: input.Content.EventType,
                    OriginEventId: null,
                    EventId: input.Content.EventId
                },
                ParentMessageGuid: input.MessageProperties.AuditId,
                MessageContentType: input.MessageProperties.EventType,
                MessageGuid: input.MessageProperties.MessageId
            },
            'type: input.MessageProperties.EventType
        }
    ]

};

type AssetsItem record {
    int Type;
    string Id;
    boolean Confirmed?;
};

type TripInformation record {

    string TripName?;
    decimal Move?;
    decimal Leg?;
    decimal Stop?;
    decimal OrderHeader?;
    AssetsItem[] Assets?;
    anydata AdditionalDataElements?;
};

type HeaderInformation record {

    string CreateDateUtc;
};

type MessageContent record {

    string EventId;
    anydata OriginEventId;
    int EventType;
    int EventCode;
    string EventDate;
    anydata Comments;
    anydata HosRuleSet;
    anydata GpsPosition;
    anydata Odometer;
    anydata Malfunctions;
    string EditDateTime;
    anydata EditByUser;
    anydata AdditionalDataElements;
    TripInformation TripInformation;
    HeaderInformation HeaderInformation;
};

type Data record {

    string MessageGuid;
    string ParentMessageGuid;
    string MessageContentType;
    MessageContent MessageContent;
};

type DtosItem record {

    string 'type;
    Data data;
};

type Output record {

    DtosItem[] dtos;
};

type GpsPosition record {

    decimal Latitude;
    decimal Longitude;
};

type AdditionalDataElementsItem record {

    string Label;
    string Value;
};

type Content record {

    string EventId;
    anydata OriginEventId;
    int EventType;
    int EventCode;
    string Comments;
    GpsPosition GpsPosition;
    decimal Odometer;
    int Malfunctions;
    string EditDateTime;
    AdditionalDataElementsItem[] AdditionalDataElements;
    TripInformation TripInformation;
    HeaderInformation HeaderInformation;
};

type MessageProperties record {

    string EventType;
    string AuditId;
    string MessageId;
};

type Input record {

    string CreateDate;
    string ContentType;
    AssetsItem[] Assets;
    Content Content;
    MessageProperties MessageProperties;
};
