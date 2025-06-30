-- chunkname: @IQIGame\\Module\\CommonActivity\\MonsterAcademy\\MonsterAcademyGirlMessageData.lua

local m = {
	dayOfPhase = 0,
	girlID = 0,
	groupID = 0,
	day = 0
}

function m.New(groupID, messageGroupPOD, girlID)
	local o = Clone(m)

	o:Init(groupID, messageGroupPOD, girlID)

	return o
end

function m:Init(groupID, messageGroupPOD, girlID)
	self.groupID = groupID
	self.girlID = girlID
	self.messageGroupPOD = messageGroupPOD

	if self.messageGroupPOD then
		self.day = self.messageGroupPOD.day
		self.dayOfPhase = self.messageGroupPOD.dayOfPhase
	end
end

function m:GetNextMessageCid()
	local endID = self.messageGroupPOD.messageIds[#self.messageGroupPOD.messageIds]

	if endID == nil then
		local nextID = CfgGalgameMonsterMessageGroupTable[self.groupID].FirstMessageID

		return {
			nextID
		}
	end

	local cfgMessage = CfgGalgameMonsterMessageTable[endID]

	return cfgMessage.NextID
end

function m:AddMessageProgress(cid)
	if table.indexOf(self.messageGroupPOD.messageIds, cid) == -1 then
		table.insert(self.messageGroupPOD.messageIds, cid)
	end
end

function m:GetSelectOption(cid)
	local index = table.indexOf(self.messageGroupPOD.messageIds, cid)
	local nextIndex = index + 1
	local selectID = self.messageGroupPOD.messageIds[nextIndex]

	return selectID
end

function m:IsComplete()
	local complete = false
	local endID = self.messageGroupPOD.messageIds[#self.messageGroupPOD.messageIds]

	if endID ~= nil then
		local cfgData = CfgGalgameMonsterMessageTable[endID]
		local nextID = cfgData.NextID[1]

		if nextID == -1 then
			complete = true
		end
	end

	return complete
end

return m
