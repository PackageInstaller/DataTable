-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/model/DivineMiyaClgFmtMo.lua

module("logic.extensions.divinemiyaclg.model.DivineMiyaClgFmtMo", package.seeall)

local DivineMiyaClgFmtMo = class("DivineMiyaClgFmtMo", ICustomFmtMo)

function DivineMiyaClgFmtMo:initParams(activityId, stageId, nextStageId, preStagId)
	self.activityId = activityId
	self.stageId = stageId

	local stageInfo = DivineMiyaClgModel.instance:getStageInfo(self.activityId, self.stageId)

	if stageInfo then
		self.stageId = stageInfo.fightStageId or stageId
	end

	self._fixRaceIds = {}

	local nextStagInfo = DivineMiyaClgModel.instance:getStageInfo(self.activityId, nextStageId)
	local preStagInfo = DivineMiyaClgModel.instance:getStageInfo(self.activityId, preStagId)

	if nextStagInfo and nextStagInfo.passedFormRace then
		for i, v in ipairs(nextStagInfo.passedFormRace) do
			self._fixRaceIds[v] = true
		end
	end

	if preStagInfo and preStagInfo.passedFormRace then
		for i, v in ipairs(preStagInfo.passedFormRace) do
			self._fixRaceIds[v] = true
		end
	end

	self._stageCfg = DivineMiyaClgConfig.instance:getStageCfg(self.activityId, self.stageId)
	self._cfgEnemy = DivineMiyaClgConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = DivineMiyaClgConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)
end

function DivineMiyaClgFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc
	self.isSetEnemySimpleForm = true

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function DivineMiyaClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.DivineMiyaClgMainView, true, self.activityId)
		UIJumper.instance:pushOneStack(ViewName.DivineMiyaClgLevelView, true, self.activityId)

		local simpleForm = self:getCurSimpleForm()

		DivineMiYaClgAgent.instance:sendPM_DivineMiYaClgFightReq(self.activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineMiyaClgFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineMiyaClgFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function DivineMiyaClgFmtMo:_changePetMo(petMo)
	return petMo
end

function DivineMiyaClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineMiyaClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DivineMiyaClgFmtMo:checkPetIsForbit(petMo, baseCheck)
	return self._fixRaceIds[petMo.raceId]
end

function DivineMiyaClgFmtMo:showForbitPetAlert(petMo)
	if self._fixRaceIds[petMo.raceId] then
		FloatWordMgr.instance:show(lang("该精灵已禁止上阵"))
	end
end

return DivineMiyaClgFmtMo
