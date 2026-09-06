-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/controller/ChuangJingRoadController.lua

module("logic.extensions.chuangjingroad.controller.ChuangJingRoadController", package.seeall)

local ChuangJingRoadController = class("ChuangJingRoadController", BaseController)

function ChuangJingRoadController:onInit()
	self:onReset()
end

function ChuangJingRoadController:onReset()
	self._challengeFmtMo = ChuangJingRoadChallengeFmtMo.New()
	self._lightBossFmtMo = ChuangJingRoadLightBossFmtMo.New()
	self._waterBossFmtMo = ChuangJingRoadWaterBossFmtMo.New()
	self._fireBossFmtMo = ChuangJingRoadFireBossFmtMo.New()
	self._grassBossFmtMo = ChuangJingRoadGrassBossFmtMo.New()
	self._resBossFmtMo = ChuangJingRoadResBossFmtMo.New()
	self._initPetInfoCallBack = nil
	self._resBossDamage = 0
end

function ChuangJingRoadController:sendGetInfo(activityId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadGetInfoReq(activityId)
end

function ChuangJingRoadController:onGetInfo(msg)
	ChuangJingRoadModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_INFO_UPDATE)
end

function ChuangJingRoadController:sendGetPetInfo(activityId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadPetInfoReq(activityId)
end

function ChuangJingRoadController:sendGetPetInfoWithCallBack(activityId, callBack)
	local info = ChuangJingRoadModel.instance:getPetInfo(activityId)

	if info then
		if callBack then
			callBack()
		end
	else
		self._initPetInfoCallBack = callBack

		ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadPetInfoReq(activityId)
	end
end

function ChuangJingRoadController:onGetPetInfo(msg)
	ChuangJingRoadModel.instance:onGetPetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_PET_INFO_UPDATE)

	if self._initPetInfoCallBack then
		self._initPetInfoCallBack()
	end

	self._initPetInfoCallBack = nil
end

function ChuangJingRoadController:sendGetFirstTeamInfo(activityId, zoneId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadFirstPassInfoReq(activityId, zoneId)
end

function ChuangJingRoadController:onGetFirstTeamInfo(msg)
	ChuangJingRoadModel.instance:onGetFirstTeamInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_FIRST_TEAM_INFO_UPDATE)
end

function ChuangJingRoadController:sendBuyPet(activityId, petId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadBuyPetReq(activityId, petId)
end

function ChuangJingRoadController:onBuyPet(msg)
	ChuangJingRoadModel.instance:onBuyPet(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_PET_INFO_UPDATE)
end

function ChuangJingRoadController:sendGetRank(activityId, zoneId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadRankReq(activityId, zoneId)
end

function ChuangJingRoadController:onGetRank(msg)
	ChuangJingRoadModel.instance:onGetRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_RANK_INFO_UPDATE)
end

function ChuangJingRoadController:sendEquipLvlUp(activityId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadEquipmentLvReq(activityId)
end

function ChuangJingRoadController:onEquipLvlUp(msg)
	ChuangJingRoadModel.instance:onEquipLvlUp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_PET_INFO_UPDATE)
end

function ChuangJingRoadController:sendPetLvlUp(activityId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadUpgradeLevelReq(activityId)
end

function ChuangJingRoadController:onPetLvlUp(msg)
	ChuangJingRoadModel.instance:onPetLvlUp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_PET_INFO_UPDATE)
end

function ChuangJingRoadController:sendHolyStripeLvlUp(activityId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadHolyStripeLevelUpReq(activityId)
end

function ChuangJingRoadController:onHolyStripeLvlUp(msg)
	ChuangJingRoadModel.instance:onHolyStripeLvlUp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_PET_INFO_UPDATE)
end

function ChuangJingRoadController:sendStarGodLvlUp(activityId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadStarGodPlusLvReq(activityId)
end

function ChuangJingRoadController:onStarGodLvlUp(msg)
	ChuangJingRoadModel.instance:onStarGodLvlUp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_PET_INFO_UPDATE)
end

function ChuangJingRoadController:sendAwakenLvlUp(activityId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadAwakenLvUpReq(activityId)
end

function ChuangJingRoadController:onAwakenLvlUp(msg)
	ChuangJingRoadModel.instance:onAwakenLvlUp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_PET_INFO_UPDATE)
end

function ChuangJingRoadController:sendGetChallengePrize(activityId, zoneId, prizeId)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadGainProgressPrizeReq(activityId, zoneId, prizeId)
end

function ChuangJingRoadController:onGetePrize(msg)
	ChuangJingRoadModel.instance:onGetePrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_INFO_UPDATE)
end

function ChuangJingRoadController:openBossMissionView(activityId, zoneId)
	if zoneId == ChuangJingRoadModel.ZONE_LIGHT then
		self:openLightBossMissionView(activityId, zoneId)
	elseif zoneId == ChuangJingRoadModel.ZONE_WATER then
		UIStateManager.instance:push(ViewName.ChuangjingroadbosswaterView, activityId, zoneId)
	elseif zoneId == ChuangJingRoadModel.ZONE_FIRE then
		UIStateManager.instance:push(ViewName.ChuangjingroadbossfireView, activityId, zoneId)
	elseif zoneId == ChuangJingRoadModel.ZONE_GRASS then
		UIStateManager.instance:push(ViewName.ChuangjingroadbossgrassView, activityId, zoneId)
	elseif zoneId == ChuangJingRoadModel.ZONE_DARK then
		UIStateManager.instance:push(ViewName.ChuangjingroadbossgrassView, activityId, zoneId)
	end
end

function ChuangJingRoadController:openResBossMissionView(activityId)
	self:sendGetPetInfoWithCallBack(activityId, function()
		self._resBossFmtMo:initParams(activityId)
		CustomFmtController.instance:showMissionView(self._resBossFmtMo)
	end)
end

function ChuangJingRoadController:openLightBossMissionView(activityId, zoneId)
	self:sendGetPetInfoWithCallBack(activityId, function()
		self._lightBossFmtMo:initParams(activityId, zoneId)
		CustomFmtController.instance:showMissionView(self._lightBossFmtMo)
	end)
end

function ChuangJingRoadController:openFireBossMissionView(activityId, zoneId, idx, creepsMasterId)
	self:sendGetPetInfoWithCallBack(activityId, function()
		self._fireBossFmtMo:initParams(activityId, zoneId, idx, creepsMasterId)
		CustomFmtController.instance:showMissionView(self._fireBossFmtMo)
	end)
end

function ChuangJingRoadController:openWaterBossMissionView(activityId, zoneId, idx, creepsMasterId)
	self:sendGetPetInfoWithCallBack(activityId, function()
		self._waterBossFmtMo:initParams(activityId, zoneId, idx, creepsMasterId)
		CustomFmtController.instance:showMissionView(self._waterBossFmtMo)
	end)
end

function ChuangJingRoadController:openGrassBossMissionView(activityId, zoneId, creepsMasterId)
	self:sendGetPetInfoWithCallBack(activityId, function()
		self._grassBossFmtMo:initParams(activityId, zoneId, creepsMasterId)
		CustomFmtController.instance:showMissionView(self._grassBossFmtMo)
	end)
end

function ChuangJingRoadController:openChallengeMissionView(activityId, zoneId, stageId)
	self:sendGetPetInfoWithCallBack(activityId, function()
		self._challengeFmtMo:initParams(activityId, zoneId, stageId)
		CustomFmtController.instance:showMissionView(self._challengeFmtMo)
	end)
end

function ChuangJingRoadController:sendChallengeFight(activityId, zoneId, stageId, form_pb)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadChallengeReq(activityId, zoneId, stageId, form_pb)
end

function ChuangJingRoadController:onChallengeFight(msg)
	return
end

function ChuangJingRoadController:sendLightBossFight(activityId, zoneId, form_pb)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadLightBossChallengeReq(activityId, zoneId, form_pb)
end

function ChuangJingRoadController:onLightBossFight(msg)
	return
end

function ChuangJingRoadController:sendWaterBossFight(activityId, zoneId, teamId, form_pb)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadWaterBossChallengeReq(activityId, zoneId, teamId, form_pb)
end

function ChuangJingRoadController:onWaterBossFight(msg)
	return
end

function ChuangJingRoadController:sendFireBossFight(activityId, zoneId, teamId, form_pb)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadFireBossChallengeReq(activityId, zoneId, teamId, form_pb)
end

function ChuangJingRoadController:onFireBossFight(msg)
	return
end

function ChuangJingRoadController:sendGrassBossFight(activityId, zoneId, stageId, form_pb)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadGrassBossChallengeReq(activityId, zoneId, stageId, form_pb)
end

function ChuangJingRoadController:onGrassBossFight(msg)
	return
end

function ChuangJingRoadController:sendResBossFight(activityId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResBossBattleEnd, self, activityId))
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadBossChallengeReq(activityId, form_pb)
end

function ChuangJingRoadController:onResBossFight(msg)
	return
end

function ChuangJingRoadController:onHandleResBossFight(msg)
	self._resBossDamage = msg.damage
end

function ChuangJingRoadController:_onResBossBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local info = ChuangJingRoadModel.instance:getInfo(activityId) or {}
	local todayMaxBossDamage = checknumber(info.todayMaxBossDamage)

	todayMaxBossDamage = math.max(todayMaxBossDamage, self._resBossDamage)

	BattleSettlementController.instance:addConditionElement(langPara("历史最高伤害：<color=#99FFB0>%s</color>", todayMaxBossDamage))
	BattleSettlementController.instance:addConditionElement(langPara("本次伤害：<color=#99FFB0>%s</color>", self._resBossDamage))
	UIStateManager.instance:open(ViewName.BattleSettlementSuccess)

	return true
end

function ChuangJingRoadController:sendResetBossFight(activityId, zoneId, param)
	ChuangJingRoadAgent.instance:sendPM_ChuangJingRoadResetBossReq(activityId, zoneId, param)
end

function ChuangJingRoadController:onResetBossFight(msg)
	ChuangJingRoadModel.instance:onResetBossFight(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CHUANG_JING_ROAD_INFO_UPDATE)
end

function ChuangJingRoadController:handleWaterBossFinish(msg)
	if msg.isPass then
		UIJumper.instance:removeTopState(ViewName.ChuangjingroadbosswaterView)
	end
end

function ChuangJingRoadController:handleFireBossFinish(msg)
	if msg.isPass then
		UIJumper.instance:removeTopState(ViewName.ChuangjingroadbossfireView)
	end
end

function ChuangJingRoadController:handleGrassBossFinish(msg)
	if msg.isPass then
		UIJumper.instance:removeTopState(ViewName.ChuangjingroadbossgrassView)
	end
end

ChuangJingRoadController.instance = ChuangJingRoadController.New()

return ChuangJingRoadController
