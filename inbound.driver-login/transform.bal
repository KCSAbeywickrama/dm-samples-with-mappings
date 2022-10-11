
type Input record {
    record {
        int Type;
        string Id;
        boolean Confirmed;
    }[] Assets;
    string CreateDate;
    string ContentType;
    record {
        int Odometer;
        string UnitTrips;
        string Position;
        record {
            string TripName;
            decimal Move;
            decimal Leg;
            decimal Stop;
            int OrderHeader;
            record {
                int Type;
                string Id;
                boolean Confirmed;
            }[] Assets;
            anydata[] AdditionalDataElements;
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

function transform(Input input) returns Output => {
    dtos: [
        {
            data: {
                MessageContent: {
                    HeaderInformation: {
                        CreateDateUtc: input.Content.HeaderInformation.CreateDateUtc
                    },
                    TripInformation: {
                        AdditionalDataElements: input.Content.TripInformation.AdditionalDataElements,
                        Assets: from var AssetsItem in input.Assets
                            select {
                                Type: AssetsItem.Type,
                                Id: AssetsItem.Id,
                                Confirmed: AssetsItem.Confirmed
                            },
                        OrderHeader: input.Content.TripInformation.OrderHeader,
                        Stop: input.Content.TripInformation.Stop,
                        Leg: input.Content.TripInformation.Leg,
                        Move: input.Content.TripInformation.Move,
                        TripName: input.Content.TripInformation.TripName
                    },
                    Position: input.Content.Position,
                    UnitTrips: input.Content.UnitTrips,
                    Odometer: input.Content.Odometer
                },
                MessageContentType: input.MessageProperties.EventType,
                ParentMessageGuid: input.MessageProperties.AuditId,
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
                int Odometer;
                string UnitTrips;
                string Position;
                record {
                    string TripName;
                    decimal Move;
                    decimal Leg;
                    decimal Stop;
                    int OrderHeader;
                    record {
                        int Type;
                        string Id;
                        boolean Confirmed;
                    }[] Assets;
                    anydata[] AdditionalDataElements;
                } TripInformation;
                record {
                    string CreateDateUtc;
                } HeaderInformation;
            } MessageContent;
        } data;
    }[] dtos;
};
