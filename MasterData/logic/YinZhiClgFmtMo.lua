-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/model/YinZhiClgFmtMo.lua

module("logic.extensions.yinzhiclg.model.YinZhiClgFmtMo", package.seeall)

local YinZhiClgFmtMo = class("YinZhiClgFmtMo", BaseCustomFmtMo)

function YinZhiClgFmtMo:initParams(activityId, phaseId, stageId, resultViewName)
	self.resultViewName = resultViewName
	self._activityId = activityId
	self._phaseId = phaseId
	self._stageId = stageId
	self._stageCfgs = YinZhiClgConfig.instance:getStageCfgs(self._activityId, self._phaseId)
	self._curStageCfg = self._stageCfgs[self._stageId]
	self._masterData = YinZhiClgConfig.instance:getTeamCfg(self._curStageCfg.creepsMasterId)
	self._creepsCfg = YinZhiClgConfig.instance:getCreepCfgs(self._curStageCfg.creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function YinZhiClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		YinZhiClgController.instance:startFight(self._activityId, self._phaseId, self._stageId, simpleForm, self.resultViewName)
	end

	self:setFightHandler(handler, nil)
end

function YinZhiClgFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function YinZhiClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function YinZhiClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

return YinZhiClgFmtMo
