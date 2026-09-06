-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialSuperFmtView.lua

module("logic.extensions.goddesstrial.view.GoddessTrialSuperFmtView", package.seeall)

local GoddessTrialSuperFmtView = class("GoddessTrialSuperFmtView", ViewComponent)

function GoddessTrialSuperFmtView:ctor()
	GoddessTrialSuperFmtView.super.ctor(self)
end

function GoddessTrialSuperFmtView:unbindEvents()
	GoddessTrialSuperFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function GoddessTrialSuperFmtView:bindEvents()
	GoddessTrialSuperFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function GoddessTrialSuperFmtView:buildUI()
	GoddessTrialSuperFmtView.super.buildUI(self)

	self._btnTip = self:getGo("btn")
end

function GoddessTrialSuperFmtView:onExit()
	GoddessTrialSuperFmtView.super.onExit(self)
end

function GoddessTrialSuperFmtView:onEnter()
	GoddessTrialSuperFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
end

function GoddessTrialSuperFmtView:_onClickTip()
	UIStateManager.instance:push(ViewName.GoddessTrialSuperFmtTipView, self._fmtMo)
end

return GoddessTrialSuperFmtView
