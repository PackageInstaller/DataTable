-- chunkname: @IQIGame\\Module\\ActiveDoubleFight\\ActiveDoubleFightRewardData.lua

ActiveDoubleFightRewardData = {
	isUp = false
}

function ActiveDoubleFightRewardData.New(eventId, win, dmgRecords, hurtScore, hurtPercentage, roundScore, round, fightListCfgId, index, isUp)
	local o = Clone(ActiveDoubleFightRewardData)

	o:Init(eventId, win, dmgRecords, hurtScore, hurtPercentage, roundScore, round, fightListCfgId, index, isUp)

	return o
end

function ActiveDoubleFightRewardData:Init(eventId, win, dmgRecords, hurtScore, hurtPercentage, roundScore, round, fightListCfgId, index, isUp)
	self.eventId = eventId
	self.win = win
	self.dmgRecords = dmgRecords
	self.hurtScore = hurtScore
	self.hurtPercentage = hurtPercentage
	self.roundScore = roundScore
	self.round = round
	self.fightListCfgId = fightListCfgId
	self.index = index
	self.isUp = isUp
end

return ActiveDoubleFightRewardData
