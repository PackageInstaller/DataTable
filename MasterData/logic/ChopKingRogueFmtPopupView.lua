-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingRogueFmtPopupView.lua

module("logic.extensions.chopking.view.ChopKingRogueFmtPopupView", package.seeall)

local ChopKingRogueFmtPopupView = class("ChopKingRogueFmtPopupView", ViewComponent)

function ChopKingRogueFmtPopupView:buildUI()
	ChopKingRogueFmtPopupView.super.buildUI(self)

	self._btnBuff = self:getBtn("btnBuff")
end

function ChopKingRogueFmtPopupView:bindEvents()
	ChopKingRogueFmtPopupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function ChopKingRogueFmtPopupView:unbindEvents()
	ChopKingRogueFmtPopupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
end

function ChopKingRogueFmtPopupView:onEnter()
	ChopKingRogueFmtPopupView.super.onEnter(self)

	self._rogueFmtMo = self:getFirstParam()
	self._activityId = self._rogueFmtMo:getActivityId()
end

function ChopKingRogueFmtPopupView:onExit()
	ChopKingRogueFmtPopupView.super.onExit(self)
end

function ChopKingRogueFmtPopupView:_onClickBuff()
	UIStateManager.instance:push(ViewName.ChopKingRogueBuffLookView, self._activityId)
end

return ChopKingRogueFmtPopupView
