-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/model/DivinehopeFmtMo.lua

module("logic.extensions.divinehope.model.DivinehopeFmtMo", package.seeall)

local DivinehopeFmtMo = class("DivinehopeFmtMo", BaseCustomFmtMo)

function DivinehopeFmtMo:initParams(activityId, floorId, wishId)
	local info = DivinehopeModel.instance:getInfo(activityId)
	local floorCfg = DivinehopeConfig.instance:getFloorCfg(activityId, floorId)
	local stageId = 0
	local cfgs = DivinehopeConfig.instance:getStageCfgsByFloor(activityId, floorId)

	for i, v in ipairs(info.divineHopeFloorInfos) do
		if v.floorId == floorId then
			stageId = #v.useWishId + 1

			break
		end
	end

	stageId = math.min(#cfgs, stageId)
	self._activityId = activityId
	self._floorId = floorId
	self._stageId = stageId
	self._stageCfg = DivinehopeConfig.instance:getStageCfg(floorCfg.stagePlanId, stageId)
	self._creepsMasterId = self._stageCfg.creepsMasterId
	self._masterData = DivinehopeConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivinehopeConfig.instance:getCreepsCfgs(self._creepsMasterId)
end

function DivinehopeFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = ""
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivinehopeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()
		local wishId = DivinehopeModel.instance:getSelectWishId(self._activityId)

		DivineHopeAgent.instance:sendPM_DivineHopeChallengeReq(self._activityId, simpleForm, self._floorId, self._stageId, wishId)
	end

	self:setFightHandler(handler, nil)
end

function DivinehopeFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivinehopeFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivinehopeFmtMo:getExtendViewName()
	return ViewName.DivinehopeextView
end

return DivinehopeFmtMo
