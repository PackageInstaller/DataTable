-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiExtremeMissionView.lua

module("logic.extensions.divinejiclg.view.DivineJiExtremeMissionView", package.seeall)

local DivineJiExtremeMissionView = class("DivineJiExtremeMissionView", ViewComponent)

function DivineJiExtremeMissionView:unbindEvents()
	DivineJiExtremeMissionView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuffDesc)
end

function DivineJiExtremeMissionView:bindEvents()
	DivineJiExtremeMissionView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuffDesc, self._onClcikBtnBuffDesc, self)
end

function DivineJiExtremeMissionView:buildUI()
	DivineJiExtremeMissionView.super.buildUI(self)

	self._btnBuffDesc = self:getGo("btnBuffDetails")
end

function DivineJiExtremeMissionView:onExit()
	DivineJiExtremeMissionView.super.onExit(self)
end

function DivineJiExtremeMissionView:onEnter()
	DivineJiExtremeMissionView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
end

function DivineJiExtremeMissionView:_onClcikBtnBuffDesc()
	UIStateManager.instance:push(ViewName.DivineJiBuffDescView, self._fmtMo.activityId, self._fmtMo.stageId)
end

return DivineJiExtremeMissionView
