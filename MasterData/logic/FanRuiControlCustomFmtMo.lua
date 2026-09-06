-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/model/FanRuiControlCustomFmtMo.lua

module("logic.extensions.fanruichallenge.model.FanRuiControlCustomFmtMo", package.seeall)

local FanRuiControlCustomFmtMo = class("FanRuiControlCustomFmtMo", ICustomFmtMo)

function FanRuiControlCustomFmtMo:initParams(activityId, stageId, childStageId, extViewName)
	self._activityId = activityId
	self._stageId = stageId
	self._childStageId = childStageId
	self._extViewName = extViewName

	local cfgStage = FanRuiChallengeConfig.instance:getControlClgStageCfg(activityId, stageId)
	local creepsMasterId = cfgStage.creepsMasterIds[childStageId]

	self._monsterCfg = FanRuiChallengeConfig.instance:getMonsterCfg(creepsMasterId)
	self._creepsCfgs = FanRuiChallengeConfig.instance:getCreepsCfgs(creepsMasterId)

	GlobalDispatcher:addListener(GlobalNotify.FanRuiControlUpdateEnemyFmt, self._onUpdateEnemyFmt, self)
end

function FanRuiControlCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.WinDesc
	self.isSetEnemySimpleForm = true

	self:setFormCondition(self._monsterCfg.formCondition)
end

function FanRuiControlCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function FanRuiControlCustomFmtMo:initFightHandler()
	local function handler()
		GlobalDispatcher:dispatch(GlobalNotify.FanRuiControlClosePosView)
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local myForm = self:getCurSimpleForm()
		local enemyForm = self:getEnemySimpleForm()

		FanRuiChallengeAgent.instance:sendPM_FanRuiClgFightThemeControlReq(self._activityId, self._childStageId, myForm, enemyForm)
	end

	self:setFightHandler(handler, nil)
end

function FanRuiControlCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function FanRuiControlCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function FanRuiControlCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function FanRuiControlCustomFmtMo:checkPetIsForbit(petMo, baseCheck)
	return FanRuiChallengeModel.instance:isBanRaceId(self._activityId, petMo.petId)
end

function FanRuiControlCustomFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show(string.format("%s已上阵过,请使用其他精灵破阵", petMo.name))
end

function FanRuiControlCustomFmtMo:onClickCloseBtn(handler)
	FanRuiControlCustomFmtMo.super.onClickCloseBtn(self, handler)
	GlobalDispatcher:dispatch(GlobalNotify.FanRuiControlClosePosView)
	GlobalDispatcher:removeListener(GlobalNotify.FanRuiControlUpdateEnemyFmt, self._onUpdateEnemyFmt, self)
end

function FanRuiControlCustomFmtMo:_onUpdateEnemyFmt(cfgCreeps)
	self._creepsCfgs = cfgCreeps

	GlobalDispatcher:dispatch(GlobalNotify.RefreshEnemyFmt)
end

function FanRuiControlCustomFmtMo:getExtendViewName()
	return self._extViewName
end

return FanRuiControlCustomFmtMo
