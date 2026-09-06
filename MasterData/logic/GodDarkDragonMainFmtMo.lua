-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/model/GodDarkDragonMainFmtMo.lua

module("logic.extensions.goddarkdragon.model.GodDarkDragonMainFmtMo", package.seeall)

local GodDarkDragonMainFmtMo = class("GodDarkDragonMainFmtMo", ICustomFmtMo)

function GodDarkDragonMainFmtMo:initParams(activityId, stageId, myLimit, enemyLimit)
	self.activityId = activityId
	self.stageId = stageId
	self.myLimit = myLimit
	self.enemyLimit = enemyLimit
	self._stageCfg = GodDarkDragonConfig.instance:getMainStageCfg(self.activityId, self.stageId)
	self._cfgEnemy = GodDarkDragonConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = GodDarkDragonConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)
	self.needUpPetCount = myLimit
end

function GodDarkDragonMainFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc
	self.validatorDescStr = langPara("本关只能上阵%d只精灵", self.myLimit)
	self.validatorDescIsShowYesOrNo = true
	self.isSetEnemySimpleForm = true

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function GodDarkDragonMainFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.GodDarkDragonMainView, true, self.activityId)
		UIJumper.instance:pushOneStack(ViewName.GodDarkDragonLevelView, true, self.activityId)

		local simpleForm = self:getCurSimpleForm()

		if #self._masterList ~= self.enemyLimit then
			FloatWordMgr.instance:show(lang("敌阵星宇祝福不符合条件"))
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack)
		elseif self:getCurFormation():getCurExistPetNumber() ~= self.myLimit then
			FloatWordMgr.instance:show(lang("我阵星宇祝福不符合条件"))
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack)
		else
			local enemyForm = self:getEnemySimpleForm()

			GodDarkDragonController.instance:sendStartMainFight(self.activityId, self.stageId, self.myLimit, self.enemyLimit, simpleForm, enemyForm)
		end
	end

	self:setFightHandler(handler, nil)
end

function GodDarkDragonMainFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function GodDarkDragonMainFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function GodDarkDragonMainFmtMo:_changePetMo(petMo)
	return petMo
end

function GodDarkDragonMainFmtMo:getMonsterConfigList()
	return self._masterList
end

function GodDarkDragonMainFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function GodDarkDragonMainFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

function GodDarkDragonMainFmtMo:getExtendViewName()
	return ViewName.GodDarkDragonFmtView
end

function GodDarkDragonMainFmtMo:setMasterList(masterList)
	self._masterList = masterList
end

function GodDarkDragonMainFmtMo:getFinalFmoList(posList, petPool, needPets)
	if self.needUpPetCount > 5 then
		posList, petPool = CustomFmtController.instance:extraPetAtFormation(self.needUpPetCount, needPets, petPool, posList, self:getCurFormation())
	elseif self.needUpPetCount < 5 then
		local num = 0

		for k, mo in pairs(petPool) do
			if not mo:isSummonedPet() then
				num = num + 1

				if num > self.needUpPetCount then
					petPool[k] = nil
				end
			end
		end
	end

	return posList, petPool
end

function GodDarkDragonMainFmtMo:onFormationChangeFinish()
	local isMatchSupportPet = self:getCurFormation():getCurExistPetNumber() == self.myLimit

	self:setValidatorDescYesOrNo(isMatchSupportPet)
end

return GodDarkDragonMainFmtMo
