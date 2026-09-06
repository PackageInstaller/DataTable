-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/view/FanRuiLotteryOverView.lua

module("logic.extensions.fanruilottery.view.FanRuiLotteryOverView", package.seeall)

local FanRuiLotteryOverView = class("FanRuiLotteryOverView", ViewComponent)

function FanRuiLotteryOverView:ctor()
	FanRuiLotteryOverView.super.ctor(self)
end

function FanRuiLotteryOverView:buildUI()
	FanRuiLotteryOverView.super.buildUI(self)

	self._btnClose = self:getGo("viewBoxGo")
	self._costCon = self:getGo("costCount/con")
	self._gainCon = self:getGo("gainCount/con")
end

function FanRuiLotteryOverView:bindEvents()
	FanRuiLotteryOverView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function FanRuiLotteryOverView:unbindEvents()
	FanRuiLotteryOverView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FanRuiLotteryOverView:onEnter()
	FanRuiLotteryOverView.super.onEnter(self)

	local params = self:getOpenParam()

	self._actId = params[1]
	self._isWin = params[2]
	self._baseCost = params[3]
	self._changeSetId = params[4]
	self._gameCfg = FanRuiLotteryConfig.instance:getGameCfg(self._actId)

	local proxy1 = MaterialMgr.setCellByCfg(self._gameCfg.chipItem, self._costCon)

	if proxy1 then
		proxy1.binder:setNum(checknumber(self._baseCost))
	end

	local proxy2 = MaterialMgr.setCellByCfg(self._gameCfg.chipItem, self._gainCon)

	if proxy2 then
		if self._isWin then
			proxy2.binder:setNum(checknumber(self._baseCost) * self._gameCfg.winRate)
		else
			proxy2.binder:setNum(checknumber(self._baseCost) * self._gameCfg.loseRate)
		end
	end
end

function FanRuiLotteryOverView:onExit()
	FanRuiLotteryOverView.super.onExit(self)
end

function FanRuiLotteryOverView:_onClickClose()
	self:close()
	UIStateManager.instance:popByName(ViewName.FanRuiLotteryGameView)

	if self._changeSetId and checknumber(self._changeSetId) > 0 then
		MaterialController.instance:showChangeSetInTemp(self._changeSetId)
	end
end

return FanRuiLotteryOverView
