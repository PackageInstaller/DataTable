
---@class CheckInItem : Entity
local CheckInItem = BaseClass("CheckInItem",Entity)
local base = Entity
local this = CheckInItem

---@param msg {data:protocol.CommonCheckIn, checkInId:number}
function this:Awake(msg)
    base.Awake(self)

	self.checkInId = msg.checkInId

	self.id = msg.data.id
	self.status = msg.data.status
	self.receiveStatus = msg.data.receive_status
	self.progress = msg.data.progress

	---@type {Id:number, Day:number, Reward:string}
    self.config = Z_CommonCheckInGroup[Z_CommonCheckIn[self.checkInId].Group][self.id]
end

---@param checkInItem protocol.CommonCheckIn
function this:UpdateData(checkInItem)
	self.id = checkInItem.id or self.id
	self.status = checkInItem.status or self.status
	self.receiveStatus = checkInItem.receive_status or self.receiveStatus
	self.progress = checkInItem.progress or self.progress
end

function this.Dispose(self)
    base.Dispose(self)
end

return this