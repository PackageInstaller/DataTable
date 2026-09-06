-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/model/GodDarkDragonBuffFmtMo.lua

module("logic.extensions.goddarkdragon.model.GodDarkDragonBuffFmtMo", package.seeall)

local GodDarkDragonBuffFmtMo = class("GodDarkDragonBuffFmtMo", ICustomFmtMo)

function GodDarkDragonBuffFmtMo:initParams(activityId, day, stageId)
	self._stageCfg = GodDarkDragonConfig.instance:getBuffStageCfg(activityId, day, stageId)
	self._cfgEnemy = GodDarkDragonConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = GodDarkDragonConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)
	self._lockPetMap = GodDarkDragonModel.instance:getLockPet(activityId)
end

function GodDarkDragonBuffFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function GodDarkDragonBuffFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.GodDarkDragonMainView, true, self._stageCfg.activityId)
		UIJumper.instance:pushOneStack(ViewName.GodDarkDragonLevelView, true, self._stageCfg.activityId)

		local simpleForm = self:getCurSimpleForm()

		GodDarkDragonController.instance:sendStartBuffFight(self._stageCfg.activityId, self._stageCfg.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function GodDarkDragonBuffFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function GodDarkDragonBuffFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function GodDarkDragonBuffFmtMo:_changePetMo(petMo)
	return petMo
end

function GodDarkDragonBuffFmtMo:getMonsterConfigList()
	return self._masterList
end

function GodDarkDragonBuffFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function GodDarkDragonBuffFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

function GodDarkDragonBuffFmtMo:checkPetIsForbit(petMo)
	if self._lockPetMap[petMo:getDefineId()] == true then
		return true
	else
		return false
	end
end

return GodDarkDragonBuffFmtMo
