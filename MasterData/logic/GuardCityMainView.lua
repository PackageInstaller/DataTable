-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityMainView.lua

module("logic.extensions.guardcity.view.GuardCityMainView", package.seeall)

local GuardCityMainView = class("GuardCityMainView", ViewComponent)

function GuardCityMainView:ctor()
	GuardCityMainView.super.ctor(self)
end

function GuardCityMainView:buildUI()
	GuardCityMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnGuard = self:getBtn("btnGuard")
	self._btnRward = self:getBtn("btnRward")
	self._btnWarorder = self:getBtn("btnWarorder")
	self._btnRank = self:getBtn("btnRank")
	self._btnShop = self:getBtn("btnShop")
	self._btnHelp = self:getBtn("btnHelp")
	self._btnLottery = self:getBtn("btnLottery")
	self._goldBarCon = self:getGo("scoreBarCon")
	self._txtPetBuff = self:getTxt("pet/txtDesc")
	self._petCell = self:getGo("pet/petTransform/petCell")
	self._petView = self:getGo("pet/petTransform")
	self._petGourp = ItemGroup.New(self._petView, self._petCell)
	self._txtCost = self:getTxt("goldBarCon/costTabCell/TxtC_Num")
	self._btnAddCost = GameUtil.asBtn(self:getGo("goldBarCon/costTabCell/Btn_Add"))
	self._txtCostTip = self:getTxt("goldBarCon/costTip/txtTip")
	self._btnShowCostTip = GameUtil.asBtn(self:getGo("goldBarCon/costTabCell/showTipRaycast"))
	self._costTip = self:getGo("goldBarCon/costTip")
	self._customInput = UICustomInput.Get(self._costTip)
	self._txtTime = self:getTxt("time/txtTime")
	self._petCon = self:getGo("petCon")
	self._redPointReward = self:getGo("btnRward/redpoint")
	self._redPointHelp = self:getGo("btnHelp/redpoint")
	self._redPointWarorder = self:getGo("btnWarorder/redpoint")
end

function GuardCityMainView:bindEvents()
	GuardCityMainView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnGuard, self._onClickGuard, self)
	GameUtil.addClickHandler(self._btnRward, self._onClickRward, self)
	GameUtil.addClickHandler(self._btnWarorder, self._onClickWarorder, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnAddCost, self._onClickAddCost, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnShowCostTip, self._onClickShowCostTip, self)
	self._customInput:AddListener(self._onCustomInputCostTip, self)
end

function GuardCityMainView:unbindEvents()
	GuardCityMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnGuard)
	GameUtil.rmClickHandler(self._btnRward)
	GameUtil.rmClickHandler(self._btnWarorder)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnAddCost)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnShowCostTip)
	self._customInput:RemoveListener()
end

function GuardCityMainView:onEnter()
	GuardCityMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityGetInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityViewSeekHelpRes, self._refreshRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityGetPrizeInfoRes, self._refreshRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityViewFriendScoreRes, self._refreshRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityBuyStrengthRes, self._PM_GuardCityBuyStrengthRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GuardCityCostChange, self._onCostChange, self)
	RedPointController.instance:regRedPoint(self._redPointWarorder, RedPointModel.ID_PASSPORT_GUARDCITY)

	self._activityId = GuardCiytModel.instance:getCurActId()

	if self._activityId == nil then
		FloatWordMgr.instance:show(lang("不在活动时间内"))
		self:close()

		return
	end

	self._actCfg = GuardCityConfig.instance:getActivityCfg(self._activityId)
	self._timeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.GUARD_CITY, self._activityId)

	local startTime = GameUtil.string2date(self._timeCfg.startTime)
	local endTime = GameUtil.string2date(self._timeCfg.endTime)

	self._txtTime.text = langPara("活动时间：%d.%d %02d:%02d - %d.%d %02d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)

	local day = GameUtil.getDaysByTimestamp(GameUtil.string2time(self._timeCfg.startTime), ServerTime.now())
	local buffCfgs = GuardCityConfig.instance:getBuffCfgs(self._actCfg.buffPlanId)

	if not buffCfgs then
		return
	end

	if day > #buffCfgs then
		day = #buffCfgs
	end

	local buffCfg = GuardCityConfig.instance:getBuffCfg(self._actCfg.buffPlanId, day)

	self._txtPetBuff.text = langPara("效果：上阵以上精灵将%s", buffCfg.des[2])

	local petList = string.split(buffCfg.des[1], ",")

	if checknumber(self._actCfg.skinId) > 0 then
		-- block empty
	end

	GameUtil.SetActive(self._costTip, false)
	self._petGourp:updateWithMoArray(petList, self._updateCell, self)
	self:_setTopGoldBar()
	GuardCityAgent.instance:sendPM_GuardCityGetInfoReq(self._activityId)
	GuardCityAgent.instance:sendPM_GuardCityGetPrizeInfoReq(self._activityId)
	GuardCityAgent.instance:sendPM_GuardCityViewSeekHelpReq(self._activityId)
end

function GuardCityMainView:onExit()
	GuardCityMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityGetInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityViewSeekHelpRes, self._refreshRedPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityGetPrizeInfoRes, self._refreshRedPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityViewFriendScoreRes, self._refreshRedPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityBuyStrengthRes, self._PM_GuardCityBuyStrengthRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuardCityCostChange, self._onCostChange, self)
	RedPointController.instance:unregRedPoint(self._redPointWarorder)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._petGourp:dispose(self._clearCell, self)
end

function GuardCityMainView:_refreshView()
	self._txtCost.text = langPara("%d/%d", GuardCiytModel.instance:getCurStrength(), GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true))

	self:_onClockCost()
	removetimer(self._onClockCost, self)
	settimer(1, self._onClockCost, self, true)
end

function GuardCityMainView:_refreshRedPoint()
	GameUtil.SetActive(self._redPointHelp, #GuardCiytModel.instance:getHelpInfo() > 0)
	GameUtil.SetActive(self._redPointReward, #GuardCiytModel.instance:getRewardScoreInfo() > 0 or GuardCiytModel.instance:haveFriendScorePrize() == true)
end

function GuardCityMainView:_updateCell(cell, data, index)
	local go = cell.mainGO
	local raceId = checknumber(data)
	local headIcon = goutil.findChild(go, "head/headIcon")

	MaterialMgr.setCell(MatType.Pet, raceId, headIcon)
end

function GuardCityMainView:_clearCell(cell)
	local go = cell.mainGO
	local headIcon = goutil.findChild(go, "head/headIcon")

	MaterialMgr.resetAll(headIcon)
end

function GuardCityMainView:_onClickRank()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.GuardCityRank)
	UIStateManager.instance:push(ViewName.GuardCityRankView, self._activityId)
end

function GuardCityMainView:_onClickShop()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.GuardCityShop)
	GotoMgr.gotoByString(self._actCfg.jumpTo1)
end

function GuardCityMainView:_onClickGuard()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.GuardCityGuard)
	GuardCityController.instance:onEndBattleAnim()
	UIStateManager.instance:push(ViewName.GuardCityGameView, self._activityId)
end

function GuardCityMainView:_onClickRward()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.GuardCityPrize)
	UIStateManager.instance:push(ViewName.GuardCityRewardTabView, self._activityId)
end

function GuardCityMainView:_onClickWarorder()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.GuardCityPassPort)
	UIStateManager.instance:push(ViewName.PassportGuardCityView)
end

function GuardCityMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, GuardCityConfig.instance:getCommonValue("MAIN_RULE_KEY", false))
end

function GuardCityMainView:_onClickHelp()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.GuardCityHelp)
	UIStateManager.instance:push(ViewName.GuardCityHelpView)
end

function GuardCityMainView:_onClickLottery()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.GuardCityLottery)
	UIStateManager.instance:push(ViewName.SuperGhostLotteryView)
end

function GuardCityMainView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = true,
		id = self._actCfg.scoreMaterials
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function GuardCityMainView:_onClickAddCost()
	local times = GuardCiytModel.instance:getBuyStrengthTimesToday() + 1
	local buyCfgs = GuardCityConfig.instance:getBuyStrengthPlans(self._actCfg.strengthPurchasePlanId)

	if times > #buyCfgs then
		times = #buyCfgs
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(buyCfgs[times].cost)
	local privilege = MaterialModel.instance:IsEnough(MatType.ACTIVITY_ITEM, self._actCfg.privilegeMaterialId, 1)
	local privilegeTimes = GuardCityConfig.instance:getCommonValue("PRIVILEGE_FREE_TIMES", true)
	local usePrivilegeTimes = GuardCiytModel.instance:getPrivilegeBuyTimesToday()

	if privilege == true and usePrivilegeTimes < privilegeTimes then
		local content = langPara("恢复%d疲劳,每日前%d次恢复疲劳无需消耗\n（今日剩余次数：%d）", GuardCityConfig.instance:getCommonValue("STRENGTH_PURCHASE_RECOVERY", false), privilegeTimes, privilegeTimes - usePrivilegeTimes)

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			GuardCityAgent.instance:sendPM_GuardCityBuyStrengthReq(self._activityId)
		end)

		return
	end

	local content = langPara("花费%d%s购买%d疲劳", matNum, MaterialMgr.getMaterialsName(matType, matId), GuardCityConfig.instance:getCommonValue("STRENGTH_PURCHASE_RECOVERY", false))

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		if GuardCiytModel.instance:getBuyStrengthTimesToday() >= #buyCfgs then
			FloatWordMgr.instance:show(lang("无剩余次数"))
		elseif MaterialModel.instance:IsEnough(matType, matId, matNum) == false then
			FloatWordMgr.instance:show(lang("所需材料不足"))
		else
			GuardCityAgent.instance:sendPM_GuardCityBuyStrengthReq(self._activityId)
		end
	end)
end

function GuardCityMainView:_onClickShowCostTip()
	GameUtil.SetActive(self._costTip, true)
end

function GuardCityMainView:_onCustomInputCostTip(hover)
	if not hover then
		GameUtil.SetActive(self._costTip, false)
	end
end

function GuardCityMainView:_onClockCost()
	if GuardCiytModel.instance:getCurStrength() >= GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true) then
		if self._txtCostTip then
			self._txtCostTip.text = langPara("每<color=#FFD87CFF>%dmin</color>恢复<color=#FFD87CFF>1</color>点\n疲劳已经达到上限", checkint(GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true) / 60))
		end
	else
		local lack = GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true) - GuardCiytModel.instance:getCurStrength()
		local needSec = lack * GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true)
		local targetTime = GuardCiytModel.instance:getStrengthStamp() + needSec - ServerTime.now()
		local nextTime = GuardCiytModel.instance:getStrengthStamp() + GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true) - ServerTime.now()

		if nextTime <= 0 then
			GuardCityController.instance:onCostAutoChange()

			nextTime = GuardCiytModel.instance:getStrengthStamp() + GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true) - ServerTime.now()
		end

		local totalDate = GameUtil.FormatTimeWords(targetTime)
		local nextDate = GameUtil.FormatTimeWords(nextTime, isNotHour)

		if self._txtCostTip then
			self._txtCostTip.text = langPara("下次恢复疲劳:%s\n完全恢复疲劳:%s", nextDate, totalDate)
		end
	end
end

function GuardCityMainView:_onCostChange()
	if self._txtCost then
		self._txtCost.text = langPara("%d/%d", GuardCiytModel.instance:getCurStrength(), GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true))
	end
end

function GuardCityMainView:_PM_GuardCityBuyStrengthRes()
	GuardCityAgent.instance:sendPM_GuardCityGetInfoReq(self._activityId)
end

return GuardCityMainView
