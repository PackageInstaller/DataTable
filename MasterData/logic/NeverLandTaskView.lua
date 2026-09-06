-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/view/NeverLandTaskView.lua

module("logic.extensions.neverland.view.NeverLandTaskView", package.seeall)

local NeverLandTaskView = class("NeverLandTaskView", EventTaskTabFrameView)

function NeverLandTaskView:ctor()
	NeverLandTaskView.super.ctor(self)
end

function NeverLandTaskView:unbindEvents()
	NeverLandTaskView.super.unbindEvents(self)
end

function NeverLandTaskView:bindEvents()
	NeverLandTaskView.super.bindEvents(self)
end

function NeverLandTaskView:buildUI()
	NeverLandTaskView.super.buildUI(self)
end

function NeverLandTaskView:onExit()
	NeverLandTaskView.super.onExit(self)
end

function NeverLandTaskView:onEnter()
	NeverLandTaskView.super.onEnter(self)
end

function NeverLandTaskView:setActId()
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.NeverLand)
end

return NeverLandTaskView
