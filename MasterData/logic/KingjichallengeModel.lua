-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/model/KingjichallengeModel.lua

module("logic.extensions.kingjichallenge.view.KingjichallengeModel", package.seeall)

local KingjichallengeModel = class("KingjichallengeModel", BaseModel)

function KingjichallengeModel:ctor()
	return
end

function KingjichallengeModel:onInit()
	self:onReset()
end

function KingjichallengeModel:onReset()
	self._info = nil
	self._customFmtMo = nil
end

function KingjichallengeModel:setInfo(msg)
	self._info = msg
end

function KingjichallengeModel:getInfo()
	return self._info
end

function KingjichallengeModel:setActivityId(activityId)
	self._activityId = activityId
end

function KingjichallengeModel:getActivityId()
	return self._activityId
end

function KingjichallengeModel:getCourierTotalDamage()
	self:_calCourierTotalDamage()

	return self._courierTotalDamage
end

function KingjichallengeModel:_calCourierTotalDamage()
	self._courierTotalDamage = 0

	if not self._info then
		return
	end

	for i, v in ipairs(self._info.courierInfo.stageList) do
		self._courierTotalDamage = self._courierTotalDamage + v.damge
	end
end

function KingjichallengeModel:getSoulPassStages()
	self:_calSoulPassStages()

	return self._soulPassStages
end

function KingjichallengeModel:_calSoulPassStages()
	self._soulPassStages = 0

	if not self._info then
		return
	end

	for i, v in ipairs(self._info.soulInfo.stageList) do
		self._soulPassStages = self._soulPassStages + v.passMaxSmallStageId
	end
end

function KingjichallengeModel:getCourierStageDamage(stageId)
	if not self._info then
		return 0
	end

	for i, v in ipairs(self._info.courierInfo.stageList) do
		if v.stageId == stageId then
			return v.damge
		end
	end

	return 0
end

function KingjichallengeModel:getCourierChallengeTime()
	if not self._info then
		return 0
	end

	return self._info.courierInfo.todayChallengeTimes
end

function KingjichallengeModel:gainPrizeRes(msg)
	if not self._info then
		return
	end

	if msg.type == GameEnum.KingjiChallengeType.Shizhe then
		self._info.courierInfo.gainPrizeIds:append(msg.prizeId)
	elseif msg.type == GameEnum.KingjiChallengeType.Hun then
		self._info.soulInfo.gainPrizeIds:append(msg.prizeId)
	elseif msg.type == GameEnum.KingjiChallengeType.Ronghe then
		for i, v in ipairs(self._info.mixInfo.stageList) do
			if v.stageId == msg.prizeId then
				v.isGainPrize = true

				break
			end
		end
	end
end

function KingjichallengeModel:getCustomFmtMo()
	self._customFmtMo = self._customFmtMo or KingjiCustomFmtMo.New()

	return self._customFmtMo
end

function KingjichallengeModel:challengeResetRes(msg)
	for i, v in ipairs(self._info.mixInfo.stageList) do
		if v.stageId == msg.stageId then
			for _, m in ipairs(v.masterList) do
				for j = #m.lockRaceIds, 1, -1 do
					m.lockRaceIds:remove(j)
				end

				for j = #m.itemList, 1, -1 do
					m.itemList:remove(j)
				end

				m.isPass = false
			end
		end
	end
end

function KingjichallengeModel:getLockRaceIds(stageId, creepsMasterId)
	local raceId_kv = {}

	for i, v in ipairs(self._info.mixInfo.stageList) do
		if v.stageId == stageId then
			for i, v0 in ipairs(v.masterList) do
				if v0.passCreepsMasterIds == creepsMasterId then
					for _, id in ipairs(v0.lockRaceIds) do
						raceId_kv[id] = id
					end

					return raceId_kv
				end
			end
		end
	end

	return raceId_kv
end

function KingjichallengeModel:getAllLockRaceIds(stageId)
	local raceId_kv = {}

	for i, v in ipairs(self._info.mixInfo.stageList) do
		if v.stageId == stageId then
			for i, v0 in ipairs(v.masterList) do
				for _, id in ipairs(v0.lockRaceIds) do
					raceId_kv[id] = id
				end
			end
		end
	end

	return raceId_kv
end

KingjichallengeModel.instance = KingjichallengeModel.New()

return KingjichallengeModel
