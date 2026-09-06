-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/controller/KingCiYuanChallengeController.lua

module("logic.extensions.kingciyuanchallenge.controller.KingCiYuanChallengeController", package.seeall)

local KingCiYuanChallengeController = class("KingCiYuanChallengeController", BaseController)

KingCiYuanChallengeController.E_KingCiYuanGetInfoRes = "E_KingCiYuanGetInfoRes"
KingCiYuanChallengeController.E_KingCiYuanBossGetPrizeRes = "E_KingCiYuanBossGetPrizeRes"
KingCiYuanChallengeController.E_KingCiYuanBossChallengeRes = "E_KingCiYuanBossChallengeRes"
KingCiYuanChallengeController.E_KingCiYuanBossBuyCountRes = "E_KingCiYuanBossBuyCountRes"
KingCiYuanChallengeController.E_KingCiYuanStageActionRes = "E_KingCiYuanStageActionRes"
KingCiYuanChallengeController.E_KingCiYuanStageResetRes = "E_KingCiYuanStageResetRes"
KingCiYuanChallengeController.E_KingCiYuanStageChangeBuffRes = "E_KingCiYuanStageChangeBuffRes"
KingCiYuanChallengeController.E_KingCiYuanBossChallengeEndRes = "E_KingCiYuanBossChallengeEndRes"
KingCiYuanChallengeController.E_KingCiYuanStageActionEndRes = "E_KingCiYuanStageActionEndRes"
KingCiYuanChallengeController.E_KingCiYuanResultConfirmRes = "E_KingCiYuanResultConfirmRes"

function KingCiYuanChallengeController:ctor()
	return
end

function KingCiYuanChallengeController:onInit()
	self:onReset()
end

function KingCiYuanChallengeController:onReset()
	self._cachePrizeId = nil
end

function KingCiYuanChallengeController:reqGainBossProgressPrize(activityId, prizeId)
	self._cachePrizeId = prizeId

	KingCiYuanChallengeAgent.instance:sendPM_KingCiYuanBossGetPrizeReq(activityId, prizeId)
end

function KingCiYuanChallengeController:reqBossFight(activityId, simpleForm)
	local viewInfos = KingCiYuanChallengeModel.instance:getViewInfos()

	for _, info in ipairs(viewInfos) do
		UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
	end

	KingCiYuanChallengeAgent.instance:sendPM_KingCiYuanBossChallengeReq(activityId, simpleForm)
end

function KingCiYuanChallengeController:reqLimitFight(activityId, stageId, simpleForm)
	BattleFacade.instance:registerResultHandler(self._handlerBattleEndAsUnit, self)
	KingCiYuanChallengeAgent.instance:sendPM_KingCiYuanStageActionReq(activityId, stageId, 0, simpleForm)
end

function KingCiYuanChallengeController:_handlerBattleEndAsUnit()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function succHandler()
		local viewInfos = KingCiYuanChallengeModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end

		UIJumper.instance:pushOneStack(ViewName.KingciyuanchallengeunitpopView, true)
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	end

	local function failHandler()
		local viewInfos = KingCiYuanChallengeModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end

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

function KingCiYuanChallengeController:handleKingCiYuanGetInfoRes(status, msg)
	if status == 0 then
		KingCiYuanChallengeModel.instance:handleKingCiYuanGetInfoRes(msg)
		self:localNotify(KingCiYuanChallengeController.E_KingCiYuanGetInfoRes)
	end
end

function KingCiYuanChallengeController:handleKingCiYuanBossGetPrizeRes(status, msg)
	if status == 0 then
		KingCiYuanChallengeModel.instance:handleKingCiYuanBossGetPrizeRes(self._cachePrizeId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
		self:localNotify(KingCiYuanChallengeController.E_KingCiYuanBossGetPrizeRes)
	end
end

function KingCiYuanChallengeController:handleKingCiYuanBossChallengeRes(status, msg)
	if status == 0 then
		KingCiYuanChallengeModel.instance:handleKingCiYuanBossChallengeRes(msg)
		self:localNotify(KingCiYuanChallengeController.E_KingCiYuanBossChallengeRes)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function KingCiYuanChallengeController:handleKingCiYuanBossBuyCountRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(lang("购买次数成功"))
		KingCiYuanChallengeModel.instance:handleKingCiYuanBossBuyCountRes(msg)
		self:localNotify(KingCiYuanChallengeController.E_KingCiYuanBossBuyCountRes)
	end
end

function KingCiYuanChallengeController:handleKingCiYuanStageActionRes(status, msg)
	if status == 0 then
		KingCiYuanChallengeModel.instance:handleKingCiYuanStageActionRes(msg)
		self:localNotify(KingCiYuanChallengeController.E_KingCiYuanStageActionRes)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function KingCiYuanChallengeController:handleKingCiYuanStageResetRes(status, msg)
	if status == 0 then
		KingCiYuanChallengeModel.instance:handleKingCiYuanStageResetRes(msg)
		self:localNotify(KingCiYuanChallengeController.E_KingCiYuanStageResetRes)
	end
end

function KingCiYuanChallengeController:handleKingCiYuanStageChangeBuffRes(status, msg)
	if status == 0 then
		KingCiYuanChallengeModel.instance:handleKingCiYuanStageChangeBuffRes(msg)
		self:localNotify(KingCiYuanChallengeController.E_KingCiYuanStageChangeBuffRes)
	end
end

function KingCiYuanChallengeController:handleKingCiYuanBossChallengeEndRes(status, msg)
	if status == 0 then
		KingCiYuanChallengeModel.instance:handleKingCiYuanBossChallengeEndRes(msg)
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.KingCiYuanChallenge, {
			damage = msg.damage
		})
		self:localNotify(KingCiYuanChallengeController.E_KingCiYuanBossChallengeEndRes)
	end
end

function KingCiYuanChallengeController:handleKingCiYuanStageActionEndRes(status, msg)
	if status == 0 then
		KingCiYuanChallengeModel.instance:handleKingCiYuanStageActionEndRes(msg)
		self:localNotify(KingCiYuanChallengeController.E_KingCiYuanStageActionEndRes)
	end
end

function KingCiYuanChallengeController:handleKingCiYuanStageFightRes(status, msg)
	if status == 0 then
		KingCiYuanChallengeModel.instance:handleKingCiYuanStageFightRes(msg)
	end
end

function KingCiYuanChallengeController:handleKingCiYuanResultConfirmRes(status, msg)
	if status == 0 then
		KingCiYuanChallengeModel.instance:handleKingCiYuanResultConfirmRes(msg)
		self:localNotify(KingCiYuanChallengeController.E_KingCiYuanResultConfirmRes)
	end
end

KingCiYuanChallengeController.instance = KingCiYuanChallengeController.New()

return KingCiYuanChallengeController
