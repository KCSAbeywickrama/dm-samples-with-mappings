interface Root {
    CreateDate: string
    ContentType: string
    Assets: {
        Type: number
        Id: string
    }[]
    Content: {
        EventId: string
        OriginEventId: string
        EventType: number
        EventCode: number
        Comments: string
        GpsPosition: {
            Latitude: number
            Longitude: number
        }
        Odometer: number
        Malfunctions: number
        EditDateTime: string
        AdditionalDataElements: {
            Label: string
            Value: string
        }[]
        TripInformation: {
            TripName: string
            Move: number
            Leg: number
            Stop: number
            OrderHeader: number
            AdditionalDataElements: string
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
                EventId: string
                OriginEventId: string
                EventType: number
                EventCode: number
                EventDate: string
                Comments: string
                HosRuleSet: string
                GpsPosition: string
                Odometer: string
                Malfunctions: string
                EditDateTime: string
                EditByUser: string
                AdditionalDataElements: string
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
                    AdditionalDataElements: string
                }
                HeaderInformation: {
                    CreateDateUtc: string
                }
            }
        }
    }[]
}

function mapFunction(input: Root): OutputRoot {
    return {
        dtos: [{
            type: input.MessageProperties.EventType,
            data: {
                ParentMessageGuid: input.MessageProperties.AuditId,
                MessageGuid: input.MessageProperties.MessageId,
                MessageContent: {
                    AdditionalDataElements: "",
                    HeaderInformation: {
                        CreateDateUtc: input.Content.HeaderInformation.CreateDateUtc
                    },
                    TripInformation: {
                        AdditionalDataElements: "",
                        Stop: input.Content.TripInformation.Stop,
                        Leg: input.Content.TripInformation.Leg,
                        Move: input.Content.TripInformation.Move,
                        TripName: input.Content.TripInformation.TripName,
                        OrderHeader: input.Content.TripInformation.OrderHeader ?? 0.0
                    },
                    EditByUser: "",
                    EditDateTime: input.Content.EditDateTime,
                    Malfunctions: "",
                    Odometer: "",
                    GpsPosition: "",
                    HosRuleSet: "",
                    Comments: "",
                    EventCode: input.Content.EventCode,
                    EventType: input.Content.EventType,
                    OriginEventId: "",
                    EventId: input.Content.EventId,
                    EventDate: "",
                    EventDate: ""
                }
            }
        }]
    }
}

// WARNING: Do not edit/remove below function
function map_S_root_S_root() {
    return mapFunction(inputroot);
}
