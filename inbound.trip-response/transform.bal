function transform(Input input) returns Output => {
    dtos: [
        {
            data: {
                MessageContent: {
                    HeaderInformation: {
                        CreateDateUtc: input.CreateDate
                    },
                    TripInformation: {
                        AdditionalDataElements: input.Content.TripInformation.AdditionalDataElements,
                        Assets: from var AssetsItem in input.Assets
                            where AssetsItem.Type == 2
                            select {
                                Type: AssetsItem.Type,
                                Id: AssetsItem.Id,
                                Confirmed: AssetsItem.Confirmed ?: false
                            },
                        OrderHeader: input.Content.TripInformation.OrderHeader,
                        Stop: input.Content.TripInformation.Stop is null ? 0.0 : <decimal>input.Content.TripInformation.Stop,
                        Move: input.Content.TripInformation.Move is null ? 0.0 : <decimal>input.Content.TripInformation.Move,
                        Leg: input.Content.TripInformation.Leg,
                        TripName: input.Content.TripInformation.TripName is null ? "" : <string>input.Content.TripInformation.TripName
                    },
                    AdditionalDataElements: input.Content.AdditionalDataElements,
                    Reason: input.Content.Reason,
                    RedispatchNow: input.Content.RedispatchNow.toString(),
                    Response: input.Content.Response
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
                int Response;
                string RedispatchNow;
                string Reason;
                record {
                    string Label;
                    string Value;
                }[] AdditionalDataElements;
                record {
                    string TripName;
                    decimal Move;
                    int Leg;
                    decimal Stop;
                    int OrderHeader;
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
        boolean Confirmed?;
    }[] Assets;
    string ContentType;
    string CreateDate;
    record {
        int Response;
        boolean RedispatchNow;
        string Reason;
        record {
            string Label;
            string Value;
        }[] AdditionalDataElements;
        record {
            anydata TripName;
            anydata Move;
            int Leg;
            anydata Stop;
            int OrderHeader;
            record {
                int Type;
                string Id;
                boolean Confirmed?;
            }[] Assets;
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
