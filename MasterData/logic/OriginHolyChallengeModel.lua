-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originholychallenge/model/OriginHolyChallengeModel.lua

module("logic.extensions.originholychallenge.model.OriginHolyChallengeModel", package.seeall)

local OriginHolyChallengeModel = class("OriginHolyChallengeModel", BaseModel)

function OriginHolyChallengeModel:onInit()
	self:onReset()
end

function OriginHolyChallengeModel:onReset()
	self.infos = {}
	self._fmtMo = nil
end

function OriginHolyChallengeModel:setInfo(msg)
	self.infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function OriginHolyChallengeModel:getPassStage(activityId)
	local info = self.infos[activityId]

	return info and checknumber(info.maxPassedStageId) or 0
end

function OriginHolyChallengeModel:setStageInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if data.pass then
		local info = self.infos[data.activityId]

		if not info then
			self.infos[data.activityId] = {}
			info = self.infos[data.activityId]
		end

		info.maxPassedStageId = math.max(checknumber(info.maxPassedStageId), checknumber(data.stageId))
	end
end

function OriginHolyChallengeModel:getFmtMo()
	self._fmtMo = self._fmtMo or OriginHolyChallengeFmtMo.New()

	return self._fmtMo
end

OriginHolyChallengeModel.instance = OriginHolyChallengeModel.New()

return OriginHolyChallengeModel
