interface Root {
    Assets: {
        Type: number
        Id: string
        Confirmed: boolean
    }[]
    CreateDate: string
    ContentType: string
    Content: {
        Odometer: number
        UnitTrips: string
        CloseTripFragments: boolean
        Position: string
        AdditionalDataElements: string
        TripInformation: {
            TripName: string
            Move: number
            Leg: number
            Stop: number
            OrderHeader: string
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
                Odometer: number
                UnitTrips: string
                CloseTripFragments: boolean
                Position: string
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
    const MessageProperties_EventType = input.MessageProperties.EventType;
    return {
        dtos: [{
            type: MessageProperties_EventType,
            data: {
                MessageGuid: input.MessageProperties.MessageId,
                ParentMessageGuid: input.MessageProperties.AuditId,
                MessageContentType: MessageProperties_EventType,
                MessageContent: {
                    Position: input.Content.Position,
                    CloseTripFragments: input.Content.CloseTripFragments,
                    UnitTrips: input.Content.UnitTrips,
                    Odometer: input.Content.Odometer,
                    AdditionalDataElements: input.Content.AdditionalDataElements,
                    HeaderInformation: input.Content.HeaderInformation,
                    TripInformation: input.Content.TripInformation
                }
            }
        }]
    }
}

// WARNING: Do not edit/remove below function
function map_S_root_S_root() {
    return mapFunction(inputroot);
}
