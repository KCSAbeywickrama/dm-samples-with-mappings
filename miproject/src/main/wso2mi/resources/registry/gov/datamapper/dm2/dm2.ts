interface Root {
input: {
Assets: {
Type: number
Id: string
Confirmed: boolean
}[]
CreateDate: string
ContentType: string
Content: {
Metrics: {
DayDrive: number
DayOnDuty: number
DayOffDuty: number
DaySleeperBerth: number
}
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
}[]
}

interface OutputRoot {
dtos: {
type: string
data: {
MessageGuid: string
ParentMessageGuid: string
MessageContentType: string
MessageContent: {
AdditionalDataElements: {
Label: string
Value: string
}[]
Metrics: {
DayDrive: number
DayOnDuty: number
DayOffDuty: number
DaySleeperBerth: number
}
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
	return {}
}

// WARNING: Do not edit/remove below function
function map_S_root_S_root() {
	return mapFunction(inputroot);
}
