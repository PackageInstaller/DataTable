-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/LuxifaEnterView.lua

module("logic.extensions.ashechallenge.view.LuxifaEnterView", package.seeall)

local LuxifaEnterView = class("LuxifaEnterView", ASheEnterView)

function LuxifaEnterView:_getActivityId()
	self._activityId = ASheModel.instance:getLuxifaActivityId()
end

function LuxifaEnterView:_getMainView()
	return ViewName.LuxifaMainView
end

return LuxifaEnterView
