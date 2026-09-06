-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerBossTriggerView.lua

module("logic.extensions.summontower.view.SummontowerBossTriggerView", package.seeall)

local SummontowerBossTriggerView = class("SummontowerBossTriggerView", ViewComponent)

function SummontowerBossTriggerView:buildUI()
	SummontowerBossTriggerView.super.buildUI(self)

	self._goNode = self:getGo("Node")
	self._btnClose = Framework.UIClickTrigger.Get(self:getGo("Node/viewBoxGo"))

	local tips = self:getTxt("Node/viewBgGo/txtBossTip")

	tips.text = "警报，守卫苏醒并加强"
end

function SummontowerBossTriggerView:bindEvents()
	SummontowerBossTriggerView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SummontowerBossTriggerView:unbindEvents()
	SummontowerBossTriggerView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SummontowerBossTriggerView:onEnter()
	SummontowerBossTriggerView.super.onEnter(self)
end

function SummontowerBossTriggerView:onExit()
	SummontowerBossTriggerView.super.onExit(self)
end

function SummontowerBossTriggerView:_onClickClose()
	self:close()
end

return SummontowerBossTriggerView
