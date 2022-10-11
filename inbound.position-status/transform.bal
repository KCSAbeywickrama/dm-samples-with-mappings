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
                                Id: idLookup(AssetsItem.Id),
                                Confirmed: false
                            },
                        OrderHeader: input.Content.TripInformation.OrderHeader ?: 0.0,
                        Stop: input.Content.TripInformation.Stop ?: 0.0,
                        Leg: input.Content.TripInformation.Leg ?: 0.0,
                        Move: input.Content.TripInformation.Move ?: 0.0,
                        TripName: input.Content.TripInformation.TripName ?: ""
                    },
                    Distance: null,
                    State: null,
                    City: null,
                    Zip: null,
                    Odometer: <int>input.Content.Odometer,
                    IgnitionStatus: input.Content.IgnitionStatus,
                    Description: input.Content.Description,
                    Position: {
                        Longitude: input.Content.Position.Longitude,
                        Latitude: input.Content.Position.Latitude
                    },
                    Heading: input.Content.Heading,
                    Speed: input.Content.Speed,
                    StatusDate: input.Content.StatusDate,
                    Assets: []
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
                anydata[] Assets;
                string StatusDate;
                int Speed;
                int Heading;
                record {
                    decimal Latitude;
                    decimal Longitude;
                } Position;
                string Description;
                string IgnitionStatus;
                int Odometer;
                anydata Zip;
                anydata City;
                anydata State;
                anydata Distance;
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
                    record {
                        string Label;
                        string Value;
                    }[] AdditionalDataElements;
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
    }[] Assets;
    string ContentType;
    string CreateDate;
    record {
        string StatusDate;
        record {
            decimal Latitude;
            decimal Longitude;
        } Position;
        int Speed;
        int Heading;
        string IgnitionStatus;
        decimal Odometer;
        string Description;
        anydata AdditionalDataElements;
        record {
            string TripName?;
            decimal Move?;
            decimal Leg?;
            decimal Stop?;
            decimal OrderHeader?;
            record {
                string Label;
                string Value;
            }[] AdditionalDataElements;
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
