-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkTaskMainView.lua

module("logic.extensions.elementspark.view.ElementSparkTaskMainView", package.seeall)

local ElementSparkTaskMainView = class("ElementSparkTaskMainView", EventTaskTabGroupFrameView)

function ElementSparkTaskMainView:setActId()
	self._activityId = ElementSparkController.instance:getActivityId()
end

return ElementSparkTaskMainView
