-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/controller/DragonLordsController.lua

module("logic.extensions.dragonlords.controller.DragonLordsController", package.seeall)

local DragonLordsController = class("DragonLordsController", BaseController)

DragonLordsController.drawEffectsConfig = {
	soundId = 30229,
	effNodes = "chouka_all/kapai1_all",
	effectTime = 9,
	effectPath = "fx_ui_chouka_10_linshi/chouka_chaoshen.prefab"
}
DragonLordsController.EquipEffsByQuality = {
	"fx_ui_chouka_10_linshi/qiu1_lan.prefab",
	"fx_ui_chouka_10_linshi/qiu1_lan.prefab",
	"fx_ui_chouka_10_linshi/qiu1_zi.prefab",
	"fx_ui_chouka_10_linshi/qiu1_huang.prefab"
}

function DragonLordsController:ctor()
	return
end

function DragonLordsController:onInit()
	self:onReset()
end

function DragonLordsController:onReset()
	self._challengeId = 0
end

function DragonLordsController:sendPM_ExtremeChallengeReq(actId, curForm)
	BattleFacade.instance:registerResultHandler(self._handleLimitBattleEnd, self)

	local simpleForm = curForm:createFormPb()

	DragonRespectChallengeAgent.instance:sendPM_ExtremeChallengeReq(actId, simpleForm)
end

function DragonLordsController:sendPM_UniversalChallengeReq(actId, challengeId, curForm, formationId)
	BattleFacade.instance:registerResultHandler(self._handleBattleEnd, self)

	local simpleForm = curForm:createFormPb()

	self._challengeId = challengeId

	DragonRespectChallengeAgent.instance:sendPM_UniversalChallengeReq(actId, challengeId, simpleForm, formationId)
end

function DragonLordsController:_getItemView()
	local matId = checknumber(DragonLordsConfig.instance:getCommonCfg("CHALLENGE_SCORE_ID"))
	local num = DrogonLordsModel.instance:getLastScore()
	local iconStr = string.format("<quad name=%s:%s|icon size=40 width=1 offsetY=-8/>", MatType.ACTIVITY_ITEM, matId)
	local matName = MaterialMgr.getMaterialsName(MatType.ACTIVITY_ITEM, matId)

	matName = string.format("<color=#F9FB39FF>%s</color>", matName)

	FloatWordMgr.instance:show(string.format("%s  %s x %d", iconStr, matName, num))
end

function DragonLordsController:_reductionView()
	local info = DrogonLordsModel.instance:getNormalInfo()

	UIJumper.instance:pushOneStack(ViewName.DragonLordsMainView)
	UIJumper.instance:pushOneStack(ViewName.DragonNationalChallengeView)
	UIJumper.instance:pushOneStack(ViewName.DragonChallengeView, nil, self._challengeId, info.infos[self._challengeId].dailyMaxSocre)
end

function DragonLordsController:_handleBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function succHandler()
		self:_reductionView()
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
		self:_getItemView()
	end

	local function failHandler()
		self:_reductionView()
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		failHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		failHandler()
	end

	return true
end

function DragonLordsController:_handleLimitBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function succHandler()
		UIJumper.instance:pushOneStack(ViewName.DragonLordsMainView)
		UIJumper.instance:pushOneStack(ViewName.DragonLimitChallengeView)
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	end

	local function failHandler()
		UIJumper.instance:pushOneStack(ViewName.DragonLordsMainView)
		UIJumper.instance:pushOneStack(ViewName.DragonLimitChallengeView)
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		failHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		failHandler()
	end

	return true
end

function DragonLordsController:failOver()
	local name = "是否结算"
	local tipsContent = DragonLordsConfig.instance:getCommonCfg("FIGHT_FAIL_TEXT")

	local function okFunc()
		UIJumper.instance:pushOneStack(ViewName.DragonLordsMainView)
		UIJumper.instance:pushOneStack(ViewName.DragonNationalChallengeView)
		UIJumper.instance:pushOneStack(ViewName.DragonChallengeView, self._challengeId)
		BattleController.instance:endBattle()
	end

	local function cencelFunc()
		local actId = DrogonLordsModel.instance:getActivityId()

		DragonRespectChallengeAgent.instance:sendPM_UniversalChallengeSettlementReq(actId, self._challengeId)
		BattleController.instance:endBattle()
	end

	TipsFacade.instance:openPopupWindow(name, tipsContent, okFunc, cencelFunc, "再次挑战", "结算")
end

function DragonLordsController:sendPM_UniversalChallengeFusionReq(actId)
	DrogonLordsModel.instance:setChangeSetId()
	DrogonLordsModel.instance:setLastDrawItems()
	DrogonLordsModel.instance:setLastDrawQuas()
	DragonRespectChallengeAgent.instance:sendPM_UniversalChallengeFusionReq(actId)
end

function DragonLordsController:scGodLotteryDone(msg)
	if msg == nil then
		return
	end

	local actId = DrogonLordsModel.instance:getActivityId()

	DragonRespectChallengeAgent.instance:sendPM_UniversalChallengeInfoReq(actId)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	DrogonLordsModel.instance:setChangeSetId(msg.changeSetId)

	local lastDrawItems = MaterialController.instance:getTempItemsByChangeSetId(msg.changeSetId)

	DrogonLordsModel.instance:setLastDrawItems(lastDrawItems)

	local cfg = DragonLordsConfig.instance:getActivityCfg()
	local planId = cfg.fusionDrawPlanId
	local itemIds = msg.prizeIds
	local list = {}

	for i, v in ipairs(itemIds or {}) do
		local tmp = DragonLordsConfig.instance:getPrizeCfg(planId, v) or {}
		local matType, id, num = MaterialMgr.getMatParams(tmp.prize)
		local itemCo = MaterialMgr.getMatCfgByStr(tmp.prize)

		if matType == MatType.Equipment then
			table.insert(list, itemCo.qualityBase)
		elseif matType == MatType.Pet then
			local rare = CharacterConfig.instance:getRareByAwakenLv(itemCo.initAwakenLv, itemCo.raceId)

			table.insert(list, rare)
		else
			table.insert(list, itemCo.quality)
		end
	end

	DrogonLordsModel.instance:setLastDrawQuas(list)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataDragonLotteryInfo)
end

function DragonLordsController:jugdeParity(num)
	local temp = num / 2 - math.floor(num / 2)

	if temp == 0 then
		return 0
	end

	return 1
end

DragonLordsController.instance = DragonLordsController.New()

return DragonLordsController
