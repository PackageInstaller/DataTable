-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/DivineelizabethmainView.lua

module("logic.extensions.ashechallenge.view.DivineelizabethmainView", package.seeall)

local DivineelizabethmainView = class("DivineelizabethmainView", ASheMainView)

function DivineelizabethmainView:_getActivityId()
	self._activityId = ASheModel.instance:getDivineelizabethActivityId()
end

function DivineelizabethmainView:_getEnterView()
	return ViewName.DivineelizabethenterView
end

function DivineelizabethmainView:_getMainView()
	return ViewName.DivineelizabethmainView
end

return DivineelizabethmainView
