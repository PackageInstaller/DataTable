-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckymoney/view/LuckyMoneyResultView.lua

module("logic.extensions.luckymoney.view.LuckyMoneyResultView", package.seeall)

local LuckyMoneyResultView = class("LuckyMoneyResultView", ViewComponent)

function LuckyMoneyResultView:buildUI()
	LuckyMoneyResultView.super.buildUI(self)

	self._btnClose = Framework.UIClickTrigger.Get(self:getGo("btnClose"))
	self._txtItemNum = self:getTxt("txtItemNum")

	local txtItemNumTips = self:getTxt("txtItemNumTips")

	txtItemNumTips.text = lang("catch_props_getprops_numtips")
end

function LuckyMoneyResultView:bindEvents()
	LuckyMoneyResultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function LuckyMoneyResultView:unbindEvents()
	LuckyMoneyResultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function LuckyMoneyResultView:onEnter()
	LuckyMoneyResultView.super.onEnter(self)

	self._txtItemNum.text = tostring(CatchPropsModel.instance:getGamePropsNum())
end

function LuckyMoneyResultView:onExitFinished()
	LuckyMoneyResultView.super.onExitFinished(self)
end

function LuckyMoneyResultView:_onClickClose()
	self:close()

	if UIStateManager.instance:isInStack(ViewName.CatchPropsGameView) then
		UIStateManager.instance:pop()
	else
		UIStateManager.instance:push(ViewName.CatchPropsView)
	end
end

return LuckyMoneyResultView
