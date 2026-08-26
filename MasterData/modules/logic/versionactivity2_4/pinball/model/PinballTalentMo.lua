-- chunkname: @modules/logic/versionactivity2_4/pinball/model/PinballTalentMo.lua

module("modules.logic.versionactivity2_4.pinball.model.PinballTalentMo", package.seeall)

local PinballTalentMo = pureTable("PinballTalentMo")

function PinballTalentMo:init(talentId)
	self._addResPers = {}
	self._marblesLv = {}
	self._unlockMarbles = {
		[PinballEnum.UnitType.MarblesNormal] = true
	}
	self.co = lua_activity178_talent.configDict[VersionActivity2_4Enum.ActivityId.Pinball][talentId]

	if not self.co then
		logError("没有天赋配置，id：" .. tostring(talentId))

		return
	end

	local arr = string.splitToNumber(self.co.effect, "#")
	local effectType = arr[1]

	if effectType == PinballEnum.TalentEffectType.UnlockMarbles then
		self._unlockMarbles[arr[2]] = true
	elseif effectType == PinballEnum.TalentEffectType.AddResPer then
		self._addResPers[arr[2]] = arr[3] / 1000
	elseif effectType == PinballEnum.TalentEffectType.EpisodeCostDec then
		self._costDec = arr[2]
	elseif effectType == PinballEnum.TalentEffectType.PlayDec then
		self._playDec = arr[2]
	elseif effectType == PinballEnum.TalentEffectType.MarblesLevel then
		self._marblesLv[arr[2]] = arr[3]
	end
end

function PinballTalentMo:getResAdd(resType)
	return self._addResPers[resType] or 0
end

function PinballTalentMo:getCostDec()
	return self._costDec or 0
end

function PinballTalentMo:getPlayDec()
	return self._playDec or 0
end

function PinballTalentMo:getIsUnlockMarbles(marblesId)
	return self._unlockMarbles[marblesId] or false
end

function PinballTalentMo:getMarblesLv(marblesId)
	return self._marblesLv[marblesId] or 1
end

return PinballTalentMo
