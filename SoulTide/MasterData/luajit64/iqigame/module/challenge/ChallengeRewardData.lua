-- chunkname: @IQIGame\\Module\\Challenge\\ChallengeRewardData.lua

ChallengeRewardData = {
	battleType = 0,
	isAutoClose = false
}

function ChallengeRewardData.New(type, win, getItems, oldMaxHurt, dmgRecords)
	local o = Clone(ChallengeRewardData)

	o:Init(type, win, getItems, oldMaxHurt, dmgRecords)

	return o
end

function ChallengeRewardData:Init(type, win, getItems, oldMaxHurt, dmgRecords)
	self.type = type
	self.win = win
	self.getItems = getItems
	self.oldMaxHurt = oldMaxHurt
	self.dmgRecords = dmgRecords
end

return ChallengeRewardData
