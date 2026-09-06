-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/model/OriginGoldenDragonClgFmtMo.lua

module("logic.extensions.origingoldendragonclg.model.OriginGoldenDragonClgFmtMo", package.seeall)

local OriginGoldenDragonClgFmtMo = class("OriginGoldenDragonClgFmtMo", BaseCustomFmtMo)

function OriginGoldenDragonClgFmtMo:initParams(activityId, stageCfg)
	self.activityId = activityId
	self.stageId = stageCfg.stageId

	local creepsMasterId = stageCfg.creepsMasterId

	self._masterData = OriginGoldenDragonClgConfig.instance:getTeamCfg(creepsMasterId) or {}
	self._creepsCfg = OriginGoldenDragonClgConfig.instance:getCreepCfgs(creepsMasterId) or {}
	self.topTitleStr = self._masterData.name or ""
	self.ruleDescStr = self._masterData.ruleDesc or ""
	self.validatorDescStr = ""

	self:tryInitPetList()
end

function OriginGoldenDragonClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginGoldenDragonClgController.instance:challengeStage(self.activityId, self.stageId, OriginGoldenDragonClgController.instance:getCurSelectProphecyId(), simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginGoldenDragonClgFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function OriginGoldenDragonClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginGoldenDragonClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginGoldenDragonClgFmtMo:getExtendViewName()
	return ViewName.OriginGoldenDragonClgFmtExView
end

function OriginGoldenDragonClgFmtMo:getActivityId()
	return self.activityId
end

function OriginGoldenDragonClgFmtMo:getStageId()
	return self.stageId
end

return OriginGoldenDragonClgFmtMo
