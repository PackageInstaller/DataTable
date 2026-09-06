-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/controller/MaterialChallengeController.lua

module("logic.extensions.materialchallenge.controller.MaterialChallengeController", package.seeall)

local MaterialChallengeController = class("MaterialChallengeController", BaseController)

function MaterialChallengeController:ctor()
	return
end

function MaterialChallengeController:onInit()
	MaterialChallengeAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_NotifyAfterChallengeRes, self._onNotifyAfterChallengeRes, self)
	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_InfoRes, self._onInfoRes, self)
	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_ChallengeRes, self._onChallengeRes, self)
	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_DailyTaskRewardRes, self._onDailyTaskRewardRes, self)
	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_OneKeyDailyTaskRewardRes, self._onOneKeyDailyTaskRewardRes, self)
	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_SweepsByTimesRes, self._onSweepsByTimesRes, self)
	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_SimpleProgressInfoRes, self._onSimpleProgressInfoRes, self)
	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_ChallengeBalanceRes, self._onChallengeBalanceRes, self)
	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_BuyChallengeTimesRes, self._onBuyChallengeTimesRes, self)
	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_GetRewardMultiplyTimesRes, self._onGetRewardMultiplyTimesRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateData, self)
end

function MaterialChallengeController:onReset()
	self._lastSweepTypeId = 0
	self._lastSweepStageId = 0
	self._lastSweepTimes = 0
	self._isGetRewardMultiplyTimes = false
end

function MaterialChallengeController:_updateData()
	MaterialChallengeModel.instance:resetSimpleProgressInfo()

	self._isGetRewardMultiplyTimes = false

	self:sendMCLG_GetRewardMultiplyTimesReq()
end

function MaterialChallengeController:showChangeSet(changeSetId, msgName)
	if msgName == "handleMCLG_NotifyAfterChallengeRes" then
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function MaterialChallengeController:sendMCLG_ChallengeReq(typeId, stageId, handler, handlerObj, errHandler)
	MaterialChallengeAgent.instance:sendMCLG_ChallengeReq(typeId, stageId, handler, handlerObj, errHandler)
end

function MaterialChallengeController:_onNotifyAfterChallengeRes(status, msg)
	if status == 0 then
		MaterialChallengeModel.instance:onNotifyAfterChallengeRes(msg)
		self:_setNewSympolFinish(msg.typeId, msg.stageId)

		if msg.isWin then
			local multiplyNum = 3

			BattleSettlementModel.instance:setRewardChangeSetId(msg.rewardChangeSetId, msg.multiplySummary, multiplyNum - 1)
		end

		if not self:isExistBaseMultiplyTimes() then
			local isDoubleTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Material, msg.typeId)

			if msg.rewardMultiply and isDoubleTime then
				MaterialChallengeModel.instance:addChallengeDoubleRewardCount(msg.typeId, 1)
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.MCLG_NotifyAfterChallengeRes, msg)
	end
end

function MaterialChallengeController:_onInfoRes(status, msg)
	if status == 0 then
		MaterialChallengeModel.instance:onInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MCLG_InfoRes, msg)
	end
end

function MaterialChallengeController:_onChallengeRes(status, msg)
	if status == 0 then
		MaterialChallengeModel.instance:onChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MCLG_ChallengeRes, msg)
	end
end

function MaterialChallengeController:_onDailyTaskRewardRes(status, msg)
	if status == 0 then
		MaterialChallengeModel.instance:onDailyTaskRewardRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MCLG_DailyTaskRewardRes, msg)
	end
end

function MaterialChallengeController:_onOneKeyDailyTaskRewardRes(status, msg)
	if status == 0 then
		MaterialChallengeModel.instance:onOneKeyDailyTaskRewardRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MCLG_OneKeyDailyTaskRewardRes, msg)
	end
end

function MaterialChallengeController:_onSweepsByTimesRes(status, msg)
	if status == 0 then
		MaterialChallengeModel.instance:onSweepsByTimesRes(msg)
		MaterialChallengeModel.instance:consumeFreeStrenghtTimes(self._lastSweepTypeId, self._lastSweepTimes)
		GlobalDispatcher:dispatch(GlobalNotify.MCLG_SweepsByTimesRes, msg)
	end

	self._lastSweepTypeId = 0
	self._lastSweepStageId = 0
	self._lastSweepTimes = 0
end

function MaterialChallengeController:_onSimpleProgressInfoRes(status, msg)
	if status == 0 then
		MaterialChallengeModel.instance:onSimpleProgressInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MCLG_SimpleProgressInfoRes, msg)
	end
end

function MaterialChallengeController:_onChallengeBalanceRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MCLG_ChallengeBalanceRes, msg.balance)
	end
end

function MaterialChallengeController:_onBuyChallengeTimesRes(status, msg)
	if status == 0 then
		MaterialChallengeModel.instance:onBuyChallengeTimesRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MCLG_BuyChallengeTimesRes, msg)
	end
end

function MaterialChallengeController:_onGetRewardMultiplyTimesRes(status, msg)
	if status == 0 then
		self._isGetRewardMultiplyTimes = true

		MaterialChallengeModel.instance:setRewardMultiplyTimes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MCLG_GetRewardMultiplyTimesRes, msg)
	end
end

function MaterialChallengeController:sendMCLG_GetRewardMultiplyTimesReq()
	if not self._isGetRewardMultiplyTimes then
		MaterialChallengeAgent.instance:sendMCLG_GetRewardMultiplyTimesReq()
	end
end

function MaterialChallengeController:openChapterView(chapterId)
	UIStateManager.instance:push(ViewName.MaterialChallengeView, chapterId)
end

function MaterialChallengeController:openStageView(chapterId, stageId)
	UIStateManager.instance:push(ViewName.ResStageView, chapterId, stageId)
end

function MaterialChallengeController:pushOneStackView(chapterId, stageId)
	BattleFacade.instance:startResCopy(chapterId, stageId)
	UIJumper.instance:pushOneStack(ViewName.PlotCopyView, true)
	UIJumper.instance:pushOneStack(ViewName.ResCopyView, true)
	UIJumper.instance:pushOneStack(ViewName.MaterialChallengeView, true, chapterId)
end

function MaterialChallengeController:loadInfoOnEnterGame()
	MaterialChallengeAgent.instance:sendMCLG_SimpleProgressInfoReq()
end

function MaterialChallengeController:_setNewSympolFinish(chapterId, stageId)
	local name = RoleModel.instance:getUserId() .. CopyConst.isNewResStage .. chapterId .. stageId
	local nameValue = UnityEngine.PlayerPrefs.GetInt(name)

	if nameValue == 0 then
		UnityEngine.PlayerPrefs.SetInt(name, 1)
	end
end

function MaterialChallengeController:_isMarked(chapterId, stageId)
	local name = RoleModel.instance:getUserId() .. CopyConst.isNewResStage .. chapterId .. stageId
	local nameValue = UnityEngine.PlayerPrefs.GetInt(name)

	return nameValue == 1
end

function MaterialChallengeController:_isExistNewStageByChapters()
	local cfgChapters = MaterialChallengeConfig.instance:getChapters()

	for i, cfgChapt in ipairs(cfgChapters) do
		if self:_isExistNewStageByChapterId(cfgChapt.chapterId) then
			return true
		end
	end

	return false
end

function MaterialChallengeController:_isExistNewStageByChapterId(chapterId)
	local cfgStages = MaterialChallengeConfig.instance:getStages(chapterId)
	local openNum = MaterialChallengeModel.instance:curOpenStageNum(chapterId)

	if cfgStages[openNum] then
		local stageId = cfgStages[openNum].stageId
		local isUnlock = MaterialChallengeModel.instance:isStageUnlock(chapterId, stageId)
		local isMarked = self:_isMarked(chapterId, stageId)

		if isUnlock and not isMarked then
			return true
		end
	end

	return false
end

function MaterialChallengeController:enterChapterView(chapterId)
	self:openChapterView(chapterId)
end

function MaterialChallengeController:enterStageView(chapterId, stageId)
	if not MaterialChallengeModel.instance:isStageUnlock(chapterId, stageId) then
		local cfg = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)

		if cfg then
			local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(cfg.unlockId)

			if cfgFuncOpen then
				FloatWordMgr.instance:show(cfgFuncOpen.description)
			end
		end

		return
	end

	self:openStageView(chapterId, stageId)
end

function MaterialChallengeController:openEvaluateView()
	local settlementType = BattleSettlementModel.instance:getType()

	if settlementType == BattleSettlementModel.Enum.ResCopy then
		ViewMgr.instance:open(ViewName.BattleEvaluateView)
	end
end

function MaterialChallengeController:closeEvaluateView()
	if ViewMgr.instance:isOpen(ViewName.BattleEvaluateView) then
		ViewMgr.instance:close(ViewName.BattleEvaluateView)
	end
end

function MaterialChallengeController:sendMCLG_SweepsByTimesReq(typeId, stageId, times, useTicket, handler)
	self._lastSweepTypeId = typeId
	self._lastSweepStageId = stageId
	self._lastSweepTimes = times

	MaterialChallengeAgent.instance:sendMCLG_SweepsByTimesReq(typeId, stageId, times, useTicket, handler, handlerObj, errHandler)
end

function MaterialChallengeController:onCountUseUp(challengeId, callback)
	local cfg = MaterialChallengeConfig.instance:getChapter(challengeId)

	if not cfg then
		printError("配置不存在 chapterId =", challengeId)

		return
	end

	local buyedCount = MaterialChallengeModel.instance:getBuyTimes(challengeId)
	local isVip = VipModel.instance:isVip()
	local maxBuyCount = VipModel.instance:getFreeTimesOfMaterialCopy(isVip, cfg.payVipId)

	if buyedCount < maxBuyCount then
		local curBuyNum = buyedCount + 1
		local cfgBuy = MaterialChallengeConfig.instance:getChallengeBuyCfg(challengeId, curBuyNum)
		local params = string.split(cfgBuy.cost, ":")

		if isVip then
			local costNum = checknumber(params[#params])
			local content = string.format("您当前为尊贵的特权用户，每日可购买%d次挑战次数，是否花费%d钻石购买1次%s挑战次数？（今日剩余：%d次）", maxBuyCount, costNum, cfg.chapterName, maxBuyCount - buyedCount)

			local function sureFunc()
				MaterialChallengeAgent.instance:sendMCLG_BuyChallengeTimesReq(challengeId)
			end

			TipsFacade.instance:openPopupCostDiamondView(costNum, content, sureFunc)
		else
			local costNum = checknumber(params[#params])
			local content = string.format("花费%d钻石，购买1次%s挑战次数？", costNum, cfg.chapterName)

			local function sureFunc()
				MaterialChallengeAgent.instance:sendMCLG_BuyChallengeTimesReq(challengeId)
			end

			TipsFacade.instance:openPopupCostDiamondView(costNum, content, sureFunc)
		end
	elseif isVip then
		FloatWordMgr.instance:show("当前购买次数已达上限，请明天再来哦")
	else
		local vipTimes = VipModel.instance:getFreeTimesOfMaterialCopy(true, cfg.payVipId)
		local freeTimes = VipModel.instance:getFreeTimesOfMaterialCopy(false, cfg.payVipId)
		local title = "提示"
		local text = string.format("您当前购买次数已达上限，无法继续购买挑战次数。成为特权用户后，每日可增加购买挑战次数上限%d次，是否成为特权用户？", vipTimes - freeTimes)

		local function func()
			if callback then
				callback()
			end

			FuncOpenController.instance:openFunc(144, GameEnum.PrivateMainView.MonthCard)
		end

		local btnText = "获取特权"

		TipsFacade.instance:openTipWindow(title, text, func, btnText)
	end
end

function MaterialChallengeController:isHaveRedPointInAllChapters()
	if not FuncOpenModel.instance:getFuncIsOpen(106) then
		return false
	end

	return self:_isShowRedPoint()
end

function MaterialChallengeController:isRedPointActive(chapterId)
	local isNotShow = GameUtil.getUserDayData("ResChapterItem" .. chapterId)
	local isExistTimes = self:isExistBaseMultiplyTimes()

	return not isNotShow and self:_isExistNewStageByChapterId(chapterId) or isExistTimes
end

function MaterialChallengeController:_isShowRedPoint()
	local cfgChapters = MaterialChallengeConfig.instance:getChapters()

	for i, cfgChapt in ipairs(cfgChapters) do
		if self:isRedPointActive(cfgChapt.chapterId) then
			return true
		end
	end

	return false
end

function MaterialChallengeController:isExistBaseMultiplyTimes()
	local maxUseCount = MaterialChallengeConfig.instance:getDailyDoubleTimes()
	local curUseCount = MaterialChallengeModel.instance:getBaseUseTimesById()

	return curUseCount < maxUseCount
end

MaterialChallengeController.instance = MaterialChallengeController.New()

return MaterialChallengeController
