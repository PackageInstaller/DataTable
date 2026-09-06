-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampInspireView.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampInspireView", package.seeall)

local FunCampInspireView = class("FunCampInspireView", ViewComponent)

function FunCampInspireView:ctor()
	FunCampInspireView.super.ctor(self)
end

function FunCampInspireView:buildUI()
	FunCampInspireView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnCoin = self:getBtn("btnCoin")
	self._btnGame = self:getBtn("btnGame")
	self._btnCoinAdd = self:getBtn("btnCoin/btnAdd")
	self._btnGameAdd = self:getBtn("btnGame/btnAdd")
	self._txtCoinCount = self:getTxt("btnCoin/txtCount")
	self._txtGameCount = self:getTxt("btnGame/txtCount")
	self._txtCampValue = self:getTxt("txtCampValue")
	self._txtPersonalValue = self:getTxt("txtPersonalValue")
	self._coinTableview = self:getGo("btnCoin/tableview")
	self._gameTableview = self:getGo("btnGame/tableview")
	self._itemcell = self:getGo("itemcell")
	self._coinScrollerList = ScrollerList.create(self._coinTableview, self._itemcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._gameScrollerList = ScrollerList.create(self._gameTableview, self._itemcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._blurBg = self:getGo("blurBg"):GetComponent(typeof(StaticBluredScreen))
	self._redPointCoin = self:getGo("btnCoin/red")
	self._redPointGame = self:getGo("btnGame/red")

	goutil.setActive(self._redPointCoin, false)
	goutil.setActive(self._redPointGame, false)
end

function FunCampInspireView:bindEvents()
	FunCampInspireView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCoin:AddClickListener(self._onClickCoin, self)
	self._btnGame:AddClickListener(self._onClickGame, self)
	self._btnCoinAdd:AddClickListener(self._onClickCoinAdd, self)
	self._btnGameAdd:AddClickListener(self._onClickGameAdd, self)
end

function FunCampInspireView:unbindEvents()
	FunCampInspireView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnCoin:RemoveClickListener()
	self._btnGame:RemoveClickListener()
	self._btnCoinAdd:RemoveClickListener()
	self._btnGameAdd:RemoveClickListener()
end

function FunCampInspireView:onEnter()
	FunCampInspireView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampGetPlayInfoRes, self._onGetPlayInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampBuyDonateTimesRes, self._onBuyDonateTimesRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampBuyTimeRes, self._onBuyGameTimeRes, self)
	self:_setBlurBg()

	self._activityId = FunCampModel.instance:getActivityId()
	self._cfgActivity = FunCampConfig.instance:getActivityCfg(self._activityId)
	self._prizeViewPlanId = self._cfgActivity.prizeViewPlanId
	self._maxCfgCoinCount = self._cfgActivity.coinDonateTimes
	self._maxCfgGameCount = self._cfgActivity.inspireGameTimes

	self:_initReward()
	self:_updateCount()
	self:_updateInspireValue()
	FunCampAgent.instance:sendPM_CB_GetPlayInfoReq(self._activityId)
end

function FunCampInspireView:onExit()
	FunCampInspireView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampGetPlayInfoRes, self._onGetPlayInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampBuyDonateTimesRes, self._onBuyDonateTimesRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampBuyTimeRes, self._onBuyGameTimeRes, self)
	self._coinScrollerList:dispose()
	self._gameScrollerList:dispose()
	self:_removeBlurBg()
end

function FunCampInspireView:_onClickClose()
	self:close()
end

function FunCampInspireView:_onClickCoin()
	if not FunCampModel.instance:isReceiveGetPlayInfo() then
		return
	end

	ViewAutoShowController.instance:saveCurModalView()
	UIStateManager.instance:push(ViewName.FunCampDonateView, FunCampModel.CoinDonate)
end

function FunCampInspireView:_onClickGame()
	if not FunCampModel.instance:isReceiveGetPlayInfo() then
		return
	end

	local curGameTime = FunCampModel.instance:getCurFlipGameTimes()
	local maxGameTime = FunCampModel.instance:getTotalMaxGameTimes(self._maxCfgGameCount)
	local isLeftTime = curGameTime < maxGameTime

	if not isLeftTime then
		FloatWordMgr.instance:show("次数用尽")

		return
	end

	ViewAutoShowController.instance:saveCurModalView()
	UIStateManager.instance:push(ViewName.FunCampGameStart)
end

function FunCampInspireView:_onClickCoinAdd()
	if not FunCampModel.instance:isReceiveGetPlayInfo() then
		return
	end

	FunCampController.instance:onClickAddBuyDonateTimes(self._activityId, self._cfgActivity.donateBuyPlanId, self._maxCfgCoinCount, FunCampModel.CoinDonate)
end

function FunCampInspireView:_onClickGameAdd()
	if not FunCampModel.instance:isReceiveGetPlayInfo() then
		return
	end

	FunCampController.instance:onClickAddBuyGameTimes(self._activityId, self._cfgActivity.gameBuyPlanId, self._maxCfgGameCount)
end

function FunCampInspireView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function FunCampInspireView:clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function FunCampInspireView:_onGetPlayInfoRes()
	self:_updateCount()
end

function FunCampInspireView:_onBuyDonateTimesRes()
	self:_updateCount()
end

function FunCampInspireView:_onBuyGameTimeRes()
	self:_updateCount()
end

function FunCampInspireView:_initReward()
	local cfgStr1 = FunCampConfig.instance:getPrizeStr(self._prizeViewPlanId, "PRIZE_INSPIRE1")
	local cfgStr2 = FunCampConfig.instance:getPrizeStr(self._prizeViewPlanId, "PRIZE_INSPIRE2")
	local list1 = MaterialMgr.changeItemStrArr(cfgStr1)
	local list2 = MaterialMgr.changeItemStrArr(cfgStr2)

	self._coinScrollerList:reloadData(list1)
	self._gameScrollerList:reloadData(list2)
end

function FunCampInspireView:_updateCount()
	local curUseCoinCount = FunCampModel.instance:getDonateTimes()
	local maxCoinCount = FunCampModel.instance:getTotalMaxDonateTimes(self._maxCfgCoinCount)
	local leftCoinCount = Mathf.Max(maxCoinCount - curUseCoinCount, 0)

	self._txtCoinCount.text = string.format("今日次数：%d/%d", leftCoinCount, self._maxCfgCoinCount)

	local curUseGameCount = FunCampModel.instance:getCurFlipGameTimes()
	local maxGameCount = FunCampModel.instance:getTotalMaxGameTimes(self._maxCfgGameCount)
	local leftGameCount = Mathf.Max(maxGameCount - curUseGameCount, 0)

	self._txtGameCount.text = string.format("今日次数：%d/%d", leftGameCount, self._maxCfgGameCount)

	self:_updateRedPoint(leftCoinCount > 0, leftGameCount > 0)
end

function FunCampInspireView:_updateRedPoint(isExistCoinTimes, isExistGameTimes)
	goutil.setActive(self._redPointCoin, isExistCoinTimes)
	goutil.setActive(self._redPointGame, isExistGameTimes)
end

function FunCampInspireView:_updateInspireValue()
	if FunCampModel.instance:isSelectCamp() then
		self._txtCampValue.text = string.format("阵营鼓舞值：%d", FunCampModel.instance:getCampInspireValue(FunCampModel.instance:getCampId()))
	end

	self._txtPersonalValue.text = string.format("个人鼓舞值：%d", FunCampModel.instance:getPersonInspireValue())
end

function FunCampInspireView:_setBlurBg()
	self._blurBg:Release()
	self._blurBg:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._blurBg:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function FunCampInspireView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function FunCampInspireView:_removeBlurBg()
	StaticBluredHook.instance:stop()
	self._blurBg:Release()
end

return FunCampInspireView
