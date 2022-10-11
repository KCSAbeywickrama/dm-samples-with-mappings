
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

type Output record {
    record {
        string 'type;
        record {
            string MessageGuid;
            string ParentMessageGuid;
            string MessageContentType;
            record {
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
                record {
                    string TripName;
                    decimal Move;
                    decimal Leg;
                    decimal Stop;
                    decimal OrderHeader;
                    record {
                        int Type;
                        string Id;
                        boolean Confirmed;
                    }[] Assets;
                    anydata AdditionalDataElements;
                } TripInformation;
                record {
                    string CreateDateUtc;
                } HeaderInformation;
            } MessageContent;
        } data;
    }[] dtos;
};

type Input record {
    string CreateDate;
    string ContentType;
    record {
        int Type;
        string Id;
        boolean Confirmed?;
    }[] Assets;
    record {
        string EventId;
        anydata OriginEventId;
        int EventType;
        int EventCode;
        string Comments;
        record {
            decimal Latitude;
            decimal Longitude;
        } GpsPosition;
        decimal Odometer;
        int Malfunctions;
        string EditDateTime;
        record {
            string Label;
            string Value;
        }[] AdditionalDataElements;
        record {
            string TripName?;
            decimal Move?;
            decimal Leg?;
            decimal Stop?;
            decimal OrderHeader?;
            anydata[] Assets;
            anydata AdditionalDataElements?;
        } TripInformation;
        record {
            string CreateDateUtc;
        } HeaderInformation;
    } Content;
    record {
        string EventType;
        string AuditId;
        string MessageId;
    } MessageProperties;
};
