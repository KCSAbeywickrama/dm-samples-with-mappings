interface Root {
    Assets: {
        Type: number
        Id: string
    }[]
    CreateDate: string
    ContentType: string
    Content: {
        Message: string
        Recipients: {
            UserId: string
            Name: string
            EmailAddress: string
        }[]
        TripInformation: {
            TripName: string
            Move: string
            Leg: string
            Stop: number
            OrderHeader: number
            AdditionalDataElements: {
                Label: string
                Value: string
            }[]
        }
        HeaderInformation: {
            CreateDateUtc: string
        }
    }
    MessageProperties: {
        EventType: string
        AuditId: string
        MessageId: string
    }
}

interface OutputRoot {
    dtos: {
        type: string
        data: {
            MessageGuid: string
            ParentMessageGuid: string
            MessageContentType: string
            MessageContent: {
                Message: string
                Recipients: {
                    UserId: string
                    Name: string
                    EmailAddress: string
                }[]
                TripInformation: {
                    TripName: string
                    Move: number
                    Leg: number
                    Stop: number
                    OrderHeader: number
                    Assets: {
                        Type: number
                        Id: string
                        Confirmed: boolean
                    }[]
                    AdditionalDataElements: {
                        Label: string
                        Value: string
                    }[]
                }
                HeaderInformation: {
                    CreateDateUtc: string
                }
            }
        }
    }[]
}

function mapFunction(input: Root): OutputRoot {
    const MessageProperties_EventType = input.MessageProperties.EventType;
    return {
        dtos: [{
            data: {
                MessageGuid: input.MessageProperties.MessageId,
                ParentMessageGuid: input.MessageProperties.AuditId,
                MessageContent: {
                    HeaderInformation: input.Content.HeaderInformation,
                    Message: input.Content.Message,
                    Recipients: input.Content.Recipients
                        .map((RecipientsItem) => {
                            return {
                                UserId: RecipientsItem.UserId,
                                Name: RecipientsItem.Name,
                                EmailAddress: RecipientsItem.EmailAddress ?? ""
                            }
                        })
                },
                MessageContentType: input.MessageProperties.EventType
            },
            type: input.MessageProperties.EventType
        }]
    }
}

// WARNING: Do not edit/remove below function
function map_S_root_S_root() {
    return mapFunction(inputroot);
}
