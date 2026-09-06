-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampgame/FunCampGameStartView.lua

module("logic.extensions.funcamp.view.funcampgame.FunCampGameStartView", package.seeall)

local FunCampGameStartView = class("FunCampGameStartView", ViewComponent)

function FunCampGameStartView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._txtNum = self:getTxt("txtNum")
	self._btnAdd = self:getBtn("txtNum/btnAdd")
	self._btnTip = self:getBtn("btnTip")
	self._goCell = self:getGo("reward/item")
	self._goTableView = self:getGo("reward/rewardview")
	self.scrollList = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FunCampGameStartView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function FunCampGameStartView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function FunCampGameStartView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.FunCampGetPlayInfoRes, self._onGetPlayInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampBuyTimeRes, self._onBuyTimeRes, self)

	self._activityId = FunCampModel.instance:getActivityId()

	local activityCfg = FunCampConfig.instance:getActivityCfg(self._activityId)

	self._cfgActivity = activityCfg
	self._prizeViewPlanId = activityCfg.prizeViewPlanId
	self._maxGameTimes = activityCfg.inspireGameTimes

	self:_initPreviewReward()
	self:_updateGameTimes()
end

function FunCampGameStartView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.FunCampGetPlayInfoRes, self._onGetPlayInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampBuyTimeRes, self._onBuyTimeRes, self)
	self.scrollList:dispose()
end

function FunCampGameStartView:_onClickClose()
	self:close()
end

function FunCampGameStartView:_onClickStart()
	if not FunCampModel.instance:isReceiveGetPlayInfo() then
		printInfo("test 未接收到协议")

		return
	end

	local curGameTime = FunCampModel.instance:getCurFlipGameTimes()
	local maxGameTime = FunCampModel.instance:getTotalMaxGameTimes(self._maxGameTimes)

	printInfo("test 游戏次数 (当前，最大) = ", curGameTime, maxGameTime)

	if maxGameTime <= curGameTime then
		FloatWordMgr.instance:show("游戏次数已用尽，请先购买游戏次数")

		return
	end

	if self._activityId then
		FunCampGameController.instance:openGameMain(self._activityId)
	end

	self:_onClickClose()
end

function FunCampGameStartView:_onClickAdd()
	FunCampController.instance:onClickAddBuyGameTimes(self._activityId, self._cfgActivity.gameBuyPlanId, self._maxGameTimes)
end

function FunCampGameStartView:_onClickTip()
	TipsFacade.instance:openRulesView("funcampflipgame")
end

function FunCampGameStartView:_onGetPlayInfoRes()
	self:_updateGameTimes()
end

function FunCampGameStartView:_onBuyTimeRes()
	self:_updateGameTimes()
end

function FunCampGameStartView:_updateGameTimes()
	local curGameTime = FunCampModel.instance:getCurFlipGameTimes()
	local maxGameTime = FunCampModel.instance:getTotalMaxGameTimes(self._maxGameTimes)
	local leftTime = Mathf.Max(maxGameTime - curGameTime, 0)

	self._txtNum.text = string.format("今日次数：%d/%d", leftTime, self._maxGameTimes)
end

function FunCampGameStartView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function FunCampGameStartView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function FunCampGameStartView:_initPreviewReward()
	local cfgStr = FunCampConfig.instance:getPrizeStr(self._prizeViewPlanId, "PRIZE_INSPIRE2")
	local list = MaterialMgr.changeItemStrArr(cfgStr)

	self.scrollList:reloadData(list)
end

return FunCampGameStartView
