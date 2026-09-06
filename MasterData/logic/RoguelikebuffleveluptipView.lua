-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikebuffleveluptipView.lua

module("logic.extensions.roguelike.view.RoguelikebuffleveluptipView", package.seeall)

local RoguelikebuffleveluptipView = class("RoguelikebuffleveluptipView", ViewComponent)

function RoguelikebuffleveluptipView:ctor()
	RoguelikebuffleveluptipView.super.ctor(self)
end

function RoguelikebuffleveluptipView:buildUI()
	RoguelikebuffleveluptipView.super.buildUI(self)

	self._txtCurBuff = self:getTxt("main/curBuff/tableview/viewport/content/txtDesc")
	self._txtNextBuff = self:getTxt("main/nextBuff/tableview/viewport/content/txtDesc")
	self._curIcon = self:getGo("main/curCoin/img")
	self._costIcon = self:getGo("main/costCoin/img")
	self._curNum = self:getTxt("main/curCoin/txtNum")
	self._costNum = self:getTxt("main/costCoin/txtNum")
	self._btnSure = self:getBtn("main/btnSure")
	self._btnClose = self:getBtn("btnClose")
end

function RoguelikebuffleveluptipView:bindEvents()
	RoguelikebuffleveluptipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function RoguelikebuffleveluptipView:unbindEvents()
	RoguelikebuffleveluptipView.super.unbindEvents(self)
end

function RoguelikebuffleveluptipView:onEnter()
	RoguelikebuffleveluptipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._buffId = params[2]
	self._curLv = params[3]
	self._nextLv = params[4]
	self._curCfg = RoguelikeConfig.instance:getGlobalBuffCfg(self._activityId, self._buffId, self._curLv)
	self._nextCfg = RoguelikeConfig.instance:getGlobalBuffCfg(self._activityId, self._buffId, self._nextLv)

	local matType, id, matNum = MaterialMgr.getMatParams(self._nextCfg.lvlUpCost)

	self._curNum.text = MaterialMgr.getMatCount(self._nextCfg.lvlUpCost)
	self._costNum.text = matNum
	self._txtCurBuff.text = self._curCfg.buffDesc
	self._txtNextBuff.text = self._nextCfg.buffDesc

	MaterialMgr.setIcon(self._curIcon, matType, id)
	MaterialMgr.setIcon(self._costIcon, matType, id)
end

function RoguelikebuffleveluptipView:onExit()
	RoguelikebuffleveluptipView.super.onExit(self)
	MaterialMgr.clearIcon(self._curIcon)
	MaterialMgr.clearIcon(self._costIcon)
end

function RoguelikebuffleveluptipView:_onClickSure()
	if not MaterialMgr.getMatEnough(self._nextCfg.lvlUpCost) then
		FloatWordMgr.instance:show("资源不足")

		return
	end

	RoguelikeAgent.instance:sendPM_RoguelikeLvlUpGlobalBuffReq(self._activityId, self._buffId)
	self:close()
end

return RoguelikebuffleveluptipView
