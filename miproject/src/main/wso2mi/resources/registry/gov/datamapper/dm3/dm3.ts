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
        Position: string
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
                Position: string
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
                }
                HeaderInformation: {
                    CreateDateUtc: string
                }
            }
        }
    }[]
}

function mapFunction(input: Root): OutputRoot {
    const subMapping: string = input.MessageProperties.EventType;
    return {
        dtos: [{
            data: {
                ParentMessageGuid: input.MessageProperties.AuditId,
                MessageGuid: input.MessageProperties.MessageId,
                MessageContent: {
                    HeaderInformation: {
                        CreateDateUtc: input.Content.HeaderInformation.CreateDateUtc
                    },
                    TripInformation: input.Content.TripInformation,
                    Position: input.Content.Position,
                    UnitTrips: input.Content.UnitTrips,
                    Odometer: input.Content.Odometer
                },
                MessageContentType: subMapping
            },
            type: subMapping
        }]
    }
}

// WARNING: Do not edit/remove below function
function map_S_root_S_root() {
    return mapFunction(inputroot);
}
