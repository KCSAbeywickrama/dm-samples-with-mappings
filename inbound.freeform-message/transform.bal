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
                        Leg: input.Content.TripInformation.Leg is null ? 0.0 : <decimal>input.Content.TripInformation.Leg,
                        Move: input.Content.TripInformation.Move is null ? 0.0 : <decimal>input.Content.TripInformation.Move,
                        OrderHeader: input.Content.TripInformation.OrderHeader,
                        Stop: input.Content.TripInformation.Stop,
                        TripName: input.Content.TripInformation.TripName
                    },
                    Recipients: from var RecipientsItem in input.Content.Recipients
                        select {
                            UserId: RecipientsItem.UserId,
                            Name: RecipientsItem.Name,
                            EmailAddress: RecipientsItem.EmailAddress is null ? "" : <string>RecipientsItem.EmailAddress
                        },
                    Message: input.Content.Message
                },
                MessageContentType: input.MessageProperties.EventType,
                MessageGuid: input.MessageProperties.MessageId,

                ParentMessageGuid: input.MessageProperties.AuditId
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
                string Message;
                record {
                    string UserId;
                    string Name;
                    string EmailAddress;
                }[] Recipients;
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
    string CreateDate;
    string ContentType;
    record {
        string Message;
        record {
            string UserId;
            string Name;
            anydata EmailAddress;
        }[] Recipients;
        record {
            string TripName;
            anydata Move;
            anydata Leg;
            decimal Stop;
            decimal OrderHeader;
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
