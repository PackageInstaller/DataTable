-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/model/HolyWaterOrderCustomFmtMo.lua

module("logic.extensions.holywaterorder.model.HolyWaterOrderCustomFmtMo", package.seeall)

local HolyWaterOrderCustomFmtMo = class("HolyWaterOrderCustomFmtMo", ICustomFmtMo)

function HolyWaterOrderCustomFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local cfgStage = HolyWaterOrderConfig.instance:getStageCfg(activityId, stageId)

	self._monsterCfg = HolyWaterOrderConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = HolyWaterOrderConfig.instance:getCreepsCfgList(cfgStage.creepsMasterId)
	self._difficultLevelNum = 3

	GlobalDispatcher:addListener(GlobalNotify.HolyWaterOrderSelectBuff, self._onSelectBuff, self)
end

function HolyWaterOrderCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.missionDesc

	self:setFormCondition(self._monsterCfg.formCondition)
	self:initPetList()
end

function HolyWaterOrderCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function HolyWaterOrderCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo, true)
	end
end

function HolyWaterOrderCustomFmtMo:initFightHandler()
	local function handler()
		GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderCloseBuff)

		local form = self:getCurSimpleForm()

		BattleFacade.instance:startHolyWaterOrderBattle()
		HolyWaterOrderAgent.instance:sendPM_HolyWaterOrderChallengeReq(self._activityId, self._stageId, self._difficultLevelNum, form)
	end

	self:setFightHandler(handler, nil)
end

function HolyWaterOrderCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function HolyWaterOrderCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function HolyWaterOrderCustomFmtMo:initPetList()
	self:clearAllPetList()

	local petInfoList = HolyWaterOrderModel.instance:getPetInfoList()

	for _, v in pairs(petInfoList) do
		self:addPetToList(v.petMo)
	end
end

function HolyWaterOrderCustomFmtMo:checkPetIsForbit(petMo, baseCheck)
	return HolyWaterOrderModel.instance:isPetLock(petMo.petId)
end

function HolyWaterOrderCustomFmtMo:showForbitPetAlert(petMo)
	if HolyWaterOrderModel.instance:getPetHp(petMo.petId) == 0 then
		FloatWordMgr.instance:show(string.format("%s血量为0,请使用其他精灵破阵", petMo.name))
	end
end

function HolyWaterOrderCustomFmtMo:onClickCloseBtn(handler)
	HolyWaterOrderCustomFmtMo.super.onClickCloseBtn(self, handler)
	GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderCloseBuff)
	GlobalDispatcher:removeListener(GlobalNotify.HolyWaterOrderSelectBuff, self._onSelectBuff, self)
end

function HolyWaterOrderCustomFmtMo:_onSelectBuff(index)
	printInfo("testHolyWaterOrderCustomFmtMo:_onSelectBuff", index)

	self._difficultLevelNum = index
end

return HolyWaterOrderCustomFmtMo
