-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampCompeteView.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampCompeteView", package.seeall)

local FunCampCompeteView = class("FunCampCompeteView", ViewComponent)

function FunCampCompeteView:ctor()
	FunCampCompeteView.super.ctor(self)
end

function FunCampCompeteView:buildUI()
	FunCampCompeteView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnClick1 = self:getBtn("btn_1")
	self._btnClick2 = self:getBtn("btn_2")
	self._btnClick3 = self:getBtn("btn_3")
	self._btnClick4 = self:getBtn("btn_4")
	self._btnAdd1 = self:getBtn("btn_1/txtCount/btnAdd")
	self._btnAdd2 = self:getBtn("btn_2/txtCount/btnAdd")
	self._btnAdd3 = self:getBtn("btn_3/txtCount/btnAdd")
	self._txtCount1 = self:getTxt("btn_1/txtCount")
	self._txtCount2 = self:getTxt("btn_2/txtCount")
	self._txtCount3 = self:getTxt("btn_3/txtCount")
	self.cell = self:getGo("cell")
	self.tableview1 = self:getGo("btn_1/tableview")
	self.tableview2 = self:getGo("btn_2/tableview")
	self.tableview3 = self:getGo("btn_3/tableview")
	self.tableview4 = self:getGo("btn_4/tableview")
	self.scrollList1 = ScrollerList.create(self.tableview1, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self.scrollList2 = ScrollerList.create(self.tableview2, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self.scrollList3 = ScrollerList.create(self.tableview3, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self.scrollList4 = ScrollerList.create(self.tableview4, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._blurBg = self:getGo("blurBg"):GetComponent(typeof(StaticBluredScreen))
	self._redPoint1 = self:getGo("btn_1/red")
	self._redPoint2 = self:getGo("btn_2/red")
	self._redPoint3 = self:getGo("btn_3/red")
	self._redPoint4 = self:getGo("btn_4/red")

	goutil.setActive(self._redPoint1, false)
	goutil.setActive(self._redPoint2, false)
	goutil.setActive(self._redPoint3, false)
	goutil.setActive(self._redPoint4, false)
end

function FunCampCompeteView:bindEvents()
	FunCampCompeteView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnClick1:AddClickListener(self._onBtnClick1, self)
	self._btnClick2:AddClickListener(self._onBtnClick2, self)
	self._btnClick3:AddClickListener(self._onBtnClick3, self)
	self._btnClick4:AddClickListener(self._onBtnClick4, self)
	self._btnAdd1:AddClickListener(self._onClickAdd1, self)
	self._btnAdd2:AddClickListener(self._onClickAdd2, self)
	self._btnAdd3:AddClickListener(self._onClickAdd3, self)
end

function FunCampCompeteView:unbindEvents()
	FunCampCompeteView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnClick1:RemoveClickListener()
	self._btnClick2:RemoveClickListener()
	self._btnClick3:RemoveClickListener()
	self._btnClick4:RemoveClickListener()
	self._btnAdd1:RemoveClickListener()
	self._btnAdd2:RemoveClickListener()
	self._btnAdd3:RemoveClickListener()
end

function FunCampCompeteView:onEnter()
	FunCampCompeteView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampGetPlayInfoRes, self._onGetPlayInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampBuyDonateTimesRes, self._onBuyDonateTimesRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampBuyTimeRes, self._onBuyGameTimeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CS_ScuffleInfoRes, self._onScuffleInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CS_BuyTimesRes, self._onCSBuyTimesRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampTaskRes, self._updateTxtCount4, self)
	self:_setBlurBg()

	self._activityId = FunCampModel.instance:getActivityId()
	self._cfgActivity = FunCampConfig.instance:getActivityCfg(self._activityId)
	self._prizeViewPlanId = self._cfgActivity.prizeViewPlanId
	self._maxCfgCoinCount = self._cfgActivity.coinDonateTimes
	self._maxCfgGameCount = checknumber(CampGameConfig.instance:getCommonValueByKey("DAILY_TIME_LIMIT"))
	self._cfgActivityNpc = FunCampNpcConfig.instance:getCfgById(self._activityId)
	self._maxCfgIntrusionTimes = self._cfgActivityNpc.dailyTimes

	self:_initRewardPreview()
	self:_updateTxtCount1()
	self:_updateTxtCount2()
	self:_updateTxtCount3()
	FunCampAgent.instance:sendPM_CB_GetPlayInfoReq(self._activityId)
	CampScuffleAgent.instance:sendCS_ScuffleInfoReq()
	FunCampAgent.instance:sendPM_CB_GetTaskInfoReq()
end

function FunCampCompeteView:onExit()
	FunCampCompeteView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampGetPlayInfoRes, self._onGetPlayInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampBuyDonateTimesRes, self._onBuyDonateTimesRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampBuyTimeRes, self._onBuyGameTimeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_ScuffleInfoRes, self._onScuffleInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_BuyTimesRes, self._onCSBuyTimesRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampTaskRes, self._updateTxtCount4, self)
	self.scrollList1:dispose()
	self.scrollList2:dispose()
	self.scrollList3:dispose()
	self.scrollList4:dispose()
	self:_removeBlurBg()
end

function FunCampCompeteView:_onGetPlayInfoRes()
	self:_updateTxtCount1()
	self:_updateTxtCount2()
	self:_updateTxtCount3()
end

function FunCampCompeteView:_onBuyDonateTimesRes()
	self:_updateTxtCount1()
end

function FunCampCompeteView:_onBuyGameTimeRes()
	self:_updateTxtCount3()
end

function FunCampCompeteView:_onScuffleInfoRes()
	self:_updateTxtCount2()
end

function FunCampCompeteView:_onCSBuyTimesRes()
	self:_updateTxtCount2()
end

function FunCampCompeteView:_onClickClose()
	self:close()
end

function FunCampCompeteView:_onBtnClick1()
	local curUseCoinCount = FunCampModel.instance:getDonateTimes()
	local maxCoinCount = FunCampModel.instance:getTotalMaxDonateTimes(self._maxCfgCoinCount)

	if curUseCoinCount < maxCoinCount then
		ViewAutoShowController.instance:saveCurModalView()
		UIStateManager.instance:push(ViewName.FunCampDonateView, FunCampModel.PlunderDonate)
	else
		FloatWordMgr.instance:show("次数用尽")
	end
end

function FunCampCompeteView:_onBtnClick2()
	if CampScuffleModel.instance:isRecieveScuffleInfoRes() then
		if not CampScuffleController.instance:isMatchGameTime() then
			FloatWordMgr.instance:show("未在开放时间哦！")

			return
		end

		local maxCfgGameCount = checknumber(CampGameConfig.instance:getCommonValueByKey("DAILY_TIME_LIMIT"))
		local curUseGameCount = CampScuffleModel.instance:getCurGameTimes()
		local maxGameCount = CampScuffleModel.instance:getTotalMaxGameTimes(maxCfgGameCount)
		local isLeft = curUseGameCount < maxGameCount

		if not isLeft then
			FloatWordMgr.instance:show("次数用尽")

			return
		end

		ViewAutoShowController.instance:saveCurModalView()
		UIStateManager.instance:push(ViewName.CampScuffleMainView)
	end
end

function FunCampCompeteView:_onBtnClick3()
	local curGameTime = FunCampModel.instance:getIntrusionTimes()
	local maxGameTime = FunCampModel.instance:getMaxIntrusionBuyTimes(self._maxCfgIntrusionTimes)

	if curGameTime < maxGameTime then
		ViewAutoShowController.instance:saveCurModalView()
		UIStateManager.instance:push(ViewName.FuncampInvadersView)
	else
		FloatWordMgr.instance:show("次数用尽")
	end
end

function FunCampCompeteView:_onBtnClick4()
	ViewAutoShowController.instance:saveCurModalView()
	UIStateManager.instance:push(ViewName.FuncampTaskView)
end

function FunCampCompeteView:_onClickAdd1()
	FunCampController.instance:onClickAddBuyDonateTimes(self._activityId, self._cfgActivity.donateBuyPlanId, self._maxCfgCoinCount, FunCampModel.PlunderDonate)
end

function FunCampCompeteView:_onClickAdd2()
	CampScuffleController.instance:onClickAddBuyScuffleTimes()
end

function FunCampCompeteView:_onClickAdd3()
	FunCampController.instance:onClickAddBuyIntrusionTimes()
end

function FunCampCompeteView:_updateTxtCount1()
	local curUseCoinCount = FunCampModel.instance:getDonateTimes()
	local maxCoinCount = FunCampModel.instance:getTotalMaxDonateTimes(self._maxCfgCoinCount)
	local leftCoinCount = Mathf.Max(maxCoinCount - curUseCoinCount, 0)

	self._txtCount1.text = string.format("今日次数：%d/%d", leftCoinCount, self._maxCfgCoinCount)

	goutil.setActive(self._redPoint1, leftCoinCount > 0)
end

function FunCampCompeteView:_updateTxtCount2()
	local txt, leftGameCount = CampScuffleController.instance:getGameTimesText()

	self._txtCount2.text = txt

	goutil.setActive(self._redPoint2, leftGameCount > 0)
end

function FunCampCompeteView:_updateTxtCount3()
	local curGameTime = FunCampModel.instance:getIntrusionTimes()
	local maxGameTime = FunCampModel.instance:getMaxIntrusionBuyTimes(self._maxCfgIntrusionTimes)
	local maxBuyTime = FunCampNpcConfig.instance:getGameBuyMax()
	local leftCount = Mathf.Max(maxGameTime - curGameTime, 0)

	self._txtCount3.text = string.format("今日次数：%d/%d", leftCount, self._maxCfgIntrusionTimes)

	local isShow = maxGameTime < maxBuyTime + checknumber(self._maxCfgIntrusionTimes)

	goutil.setActive(self._btnAdd3.gameObject, false)
	goutil.setActive(self._redPoint3, leftCount > 0)
end

function FunCampCompeteView:_updateTxtCount4()
	local isHaveReward = FunCampModel.instance:getTaskHaveReward()

	goutil.setActive(self._redPoint4, isHaveReward)
end

function FunCampCompeteView:_initRewardPreview()
	local cfgStr1 = FunCampConfig.instance:getPrizeStr(self._prizeViewPlanId, "PRIZE_BATTLE1")
	local list1 = MaterialMgr.changeItemStrArr(cfgStr1)

	self.scrollList1:reloadData(list1)

	local cfgStr2 = FunCampConfig.instance:getPrizeStr(self._prizeViewPlanId, "PRIZE_BATTLE2")
	local list2 = MaterialMgr.changeItemStrArr(cfgStr2)

	self.scrollList2:reloadData(list2)

	local cfgStr3 = FunCampConfig.instance:getPrizeStr(self._prizeViewPlanId, "PRIZE_BATTLE3")
	local list3 = MaterialMgr.changeItemStrArr(cfgStr3)

	self.scrollList3:reloadData(list3)

	local cfgStr4 = FunCampConfig.instance:getPrizeStr(self._prizeViewPlanId, "PRIZE_BATTLE4")
	local list4 = MaterialMgr.changeItemStrArr(cfgStr4)

	self.scrollList4:reloadData(list4)
end

function FunCampCompeteView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function FunCampCompeteView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function FunCampCompeteView:_setBlurBg()
	self._blurBg:Release()
	self._blurBg:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._blurBg:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function FunCampCompeteView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function FunCampCompeteView:_removeBlurBg()
	StaticBluredHook.instance:stop()
	self._blurBg:Release()
end

return FunCampCompeteView
