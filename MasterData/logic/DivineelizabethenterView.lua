-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/DivineelizabethenterView.lua

module("logic.extensions.ashechallenge.view.DivineelizabethenterView", package.seeall)

local DivineelizabethenterView = class("DivineelizabethenterView", ASheEnterView)

function DivineelizabethenterView:_getActivityId()
	self._activityId = ASheModel.instance:getDivineelizabethActivityId()
end

function DivineelizabethenterView:_getMainView()
	return ViewName.DivineelizabethmainView
end

return DivineelizabethenterView
