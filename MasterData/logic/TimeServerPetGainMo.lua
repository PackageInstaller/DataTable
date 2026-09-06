-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeserverpetgain/model/TimeServerPetGainMo.lua

module("logic.extensions.timeserverpetgain.model.TimeServerPetGainMo", package.seeall)

local TimeServerPetGainMo = class("TimeServerPetGainMo", BaseModel)

function TimeServerPetGainMo:ctor(activityId)
	self._activityId = activityId
	self._gainUserNum = 0
	self._prizeIds = {}
end

function TimeServerPetGainMo:TimeServerPetGainGetInfoRes(msg)
	self._gainUserNum = msg.gainUserNum
	self._prizeIds = GameUtil.pbToTable(msg.prizeIds) or {}
end

function TimeServerPetGainMo:TimeServerPetGainGetProgressPrizeRes(msg)
	self._prizeIds = GameUtil.pbToTable(msg.prizeIds) or {}
end

function TimeServerPetGainMo:getProgressPlanId()
	local cfg = TimeServerPetGainConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.progressPlanId or 0)
end

function TimeServerPetGainMo:isRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self._gainUserNum

	if isScoreEnough then
		local isGeted = self:isRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function TimeServerPetGainMo:isRewardGeted(prizeId)
	return TableUtil.isHad(self._prizeIds, prizeId)
end

function TimeServerPetGainMo:isAnyRewardCanGet()
	local cfgs = TimeServerPetGainConfig.instance:getProgressCfgList(self:getProgressPlanId())

	if cfgs then
		for i, v in ipairs(cfgs) do
			if self:isRewardCanGet(v.id, v.userNum) then
				return true
			end
		end

		return false
	else
		return false
	end
end

function TimeServerPetGainMo:getUserNum()
	return self._gainUserNum
end

return TimeServerPetGainMo
