-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxGameStartView.lua

module("logic.extensions.sxgame.view.SxGameStartView", package.seeall)

local SxGameStartView = class("SxGameStartView", ViewComponent)

function SxGameStartView:ctor()
	SxGameStartView.super.ctor(self)
end

function SxGameStartView:bindEvents()
	self._Btn_Start:AddClickListener(self._onClickStart, self)
	self._Btn_Exchange:AddClickListener(self._onClickExchange, self)
	self._Btn_Close:AddClickListener(self._onCloseFun, self)
end

function SxGameStartView:unbindEvents()
	self._Btn_Start:RemoveClickListener()
	self._Btn_Exchange:RemoveClickListener()
	self._Btn_Close:RemoveClickListener()
end

function SxGameStartView:buildUI()
	self._Btn_Start = self:getBtn("Btn_Start")
	self._Btn_Exchange = self:getBtn("Btn_Exchange")
	self._Btn_Close = self:getBtn("Btn_Close")
	self._Txt_Cnt = self:getGo("Txt_Cnt"):GetComponent(goutil.Type_UIText)
	self._Redpoint = self:getGo("redPoint")
end

function SxGameStartView:destroyUI()
	return
end

function SxGameStartView:onEnter()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self, NotifyPriority.Low)
	RedPointController.instance:regRedPoint(self._Redpoint, RedPointModel.ID_SxGame)
	GlobalDispatcher:addListener(GlobalNotify.SxActInfoUpdate, self._onGameInfo, self)
	self:_reloadData()
end

function SxGameStartView:onEnterFinished()
	return
end

function SxGameStartView:onExit()
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
	GlobalDispatcher:removeListener(GlobalNotify.SxActInfoUpdate, self._onGameInfo, self)
	RedPointController.instance:unregRedPoint(self._Redpoint)
end

function SxGameStartView:_reloadData()
	SxGameController.instance:sendGetActInfo()
end

function SxGameStartView:onExitFinished()
	return
end

function SxGameStartView:_onClickStart()
	local times = SxGameController.instance:getResiduePlayTimes()

	SxGameController.instance:openSxgameView(times)
end

function SxGameStartView:_onGameInfo()
	local remainCnt = SxGameController.instance:getResiduePlayTimes()

	self._Txt_Cnt.text = ""

	if remainCnt then
		self._Txt_Cnt.text = string.format("今天还剩下:<color=#78ff27>%d次</color>", remainCnt)
	end
end

function SxGameStartView:_onClickExchange()
	UIStateManager.instance:push(ViewName.Exchange, ExchangeModel.TAB_XIAONUOBIAN)
end

function SxGameStartView:_onCloseFun()
	self:close()
end

return SxGameStartView
