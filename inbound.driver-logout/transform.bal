
function transform(Input input) returns Output => {
    dtos: [
        {
            data: {
                MessageContent: {
                    HeaderInformation: {
                        CreateDateUtc: input.Content.HeaderInformation.CreateDateUtc
                    },
                    TripInformation: {
                        AdditionalDataElements: input.Content.TripInformation.AdditionalDataElements is () ? "" : <string>input.Content.TripInformation.AdditionalDataElements,
                        Assets: from var AssetsItem in input.Content.TripInformation.Assets
                            select {
                                Type: AssetsItem.Type,
                                Id: idLookup(AssetsItem.Id),
                                Confirmed: AssetsItem.Confirmed
                            },
                        OrderHeader: input.Content.TripInformation.OrderHeader is null ? 0.0 : <decimal>input.Content.TripInformation.OrderHeader,
                        Stop: input.Content.TripInformation.Stop,
                        Leg: input.Content.TripInformation.Leg,
                        Move: input.Content.TripInformation.Move,
                        TripName: input.Content.TripInformation.TripName
                    },
                    AdditionalDataElements: input.Content.AdditionalDataElements,
                    Position: input.Content.Position,
                    CloseTripFragments: input.Content.CloseTripFragments,
                    UnitTrips: input.Content.UnitTrips,
                    Odometer: <decimal>input.Content.Odometer
                },
                MessageGuid: input.MessageProperties.MessageId,
                ParentMessageGuid: input.MessageProperties.AuditId,
                MessageContentType: input.MessageProperties.EventType
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
                decimal Odometer;
                string UnitTrips;
                boolean CloseTripFragments;
                string Position;
                string AdditionalDataElements;
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
                    string AdditionalDataElements;
                } TripInformation;
                record {
                    string CreateDateUtc;
                } HeaderInformation;
            } MessageContent;
        } data;
    }[] dtos;
};

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
        boolean CloseTripFragments;
        string Position;
        string AdditionalDataElements;
        record {
            string TripName;
            decimal Move;
            decimal Leg;
            decimal Stop;
            anydata OrderHeader;
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
    } Content;
    record {
        string EventType;
        string AuditId;
        string MessageId;
    } MessageProperties;
};
