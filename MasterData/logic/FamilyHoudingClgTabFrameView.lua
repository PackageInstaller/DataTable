-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/tab/FamilyHoudingClgTabFrameView.lua

module("logic.extensions.familyhoundingclg.view.tab.FamilyHoudingClgTabFrameView", package.seeall)

local FamilyHoudingClgTabFrameView = class("FamilyHoudingClgTabFrameView", TabFrameWorkMainView)

function FamilyHoudingClgTabFrameView:onEnter()
	FamilyHoudingClgTabFrameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_FamilyHounding_GetInfoRes, self._onUpdate, self)
end

function FamilyHoudingClgTabFrameView:_getFrameId()
	return 5
end

return FamilyHoudingClgTabFrameView
