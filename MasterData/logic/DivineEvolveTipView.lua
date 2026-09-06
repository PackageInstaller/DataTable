-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveTipView.lua

module("logic.extensions.divineevolve.view.DivineEvolveTipView", package.seeall)

local DivineEvolveTipView = class("DivineEvolveTipView", ViewComponent)

function DivineEvolveTipView:ctor()
	DivineEvolveTipView.super.ctor(self)
end

function DivineEvolveTipView:buildUI()
	DivineEvolveTipView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._text = self:getTxt("txt")
end

function DivineEvolveTipView:bindEvents()
	DivineEvolveTipView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function DivineEvolveTipView:unbindEvents()
	DivineEvolveTipView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineEvolveTipView:onEnter()
	local params = self:getOpenParam()

	self._callback = self:getFirstParam()
	self._text.text = params and not string.nilorempty(params[2]) and params[2] or lang("完成神启挑战")
end

function DivineEvolveTipView:_onClickClose()
	GameUtil.callBack(self._callback)
	self:close()
	UIStateManager.instance:popByName(ViewName.NoahChallengeView)
	UIStateManager.instance:popByName(ViewName.NuoyaShenqiChallenge)
end

return DivineEvolveTipView
