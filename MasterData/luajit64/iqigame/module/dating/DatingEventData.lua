-- chunkname: @IQIGame\\Module\\Dating\\DatingEventData.lua

DatingEventData = {
	isUnlock = false,
	isNew = false,
	isReverseEvent = false
}

function DatingEventData.New()
	local o = Clone(DatingEventData)

	return o
end

function DatingEventData:Init(id, unlock, new, ending)
	self.cfgEventID = id
	self.cfgDatingEvent = CfgDatingEventsTable[id]
	self.isUnlock = unlock
	self.isNew = new
	self.endingList = ending
	self.isReverseEvent = self.cfgDatingEvent.ReverseBe == 0
end

function DatingEventData:GetPercent()
	local total = #self.cfgDatingEvent.Endings
	local complete = 0

	if self.endingList ~= nil then
		complete = #self.endingList
	end

	return complete, total
end
