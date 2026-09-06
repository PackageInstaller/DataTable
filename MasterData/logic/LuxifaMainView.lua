-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/LuxifaMainView.lua

module("logic.extensions.ashechallenge.view.LuxifaMainView", package.seeall)

local LuxifaMainView = class("LuxifaMainView", ASheMainView)

function LuxifaMainView:_getActivityId()
	self._activityId = ASheModel.instance:getLuxifaActivityId()
end

function LuxifaMainView:_getEnterView()
	return ViewName.LuxifaEnterView
end

function LuxifaMainView:_getMainView()
	return ViewName.LuxifaMainView
end

return LuxifaMainView
