interface Root {
    Assets: {
        Type: number
        Id: string
    }[]
    ContentType: string
    CreateDate: string
    Content: {
        StatusDate: string
        Position: {
            Latitude: number
            Longitude: number
        }
        Speed: number
        Heading: number
        IgnitionStatus: string
        Odometer: number
        Description: string
        AdditionalDataElements: string
        TripInformation: {
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
                StatusDate: string
                Speed: number
                Heading: number
                Position: {
                    Latitude: number
                    Longitude: number
                }
                Description: string
                IgnitionStatus: string
                Odometer: number
                Zip: string
                City: string
                State: string
                Distance: string
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
    return {
        dtos: [{
            type: input.MessageProperties.EventType,
            data: {
                MessageGuid: input.MessageProperties.MessageId,
                ParentMessageGuid: input.MessageProperties.AuditId,
                MessageContentType: input.MessageProperties.EventType,
                MessageContent: {
                    Distance: "",
                    State: "",
                    City: "",
                    Zip: "",
                    Odometer: floor(input.Content.Odometer),
                    IgnitionStatus: input.Content.IgnitionStatus,
                    Description: input.Content.Description,
                    Heading: input.Content.Heading,
                    Speed: input.Content.Speed,
                    StatusDate: input.Content.StatusDate,
                    HeaderInformation: input.Content.HeaderInformation,
                    Position: input.Content.Position
                }
            }
        }]
    }
}

// WARNING: Do not edit/remove below function
function map_S_root_S_root() {
    return mapFunction(inputroot);
}

/**
 * #### AUTO-GENERATED FUNCTION, DO NOT MODIFY ####
 * Finds the floor of a number.
 * * @param num - The number to find the floor of.
 * * @returns The floor of the number.
 */
function floor(num: number): number {
    return Math.floor(num);
}
