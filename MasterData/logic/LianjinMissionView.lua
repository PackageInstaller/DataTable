-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lianjinmm/LianjinMissionView.lua

module("logic.extensions.timelimitedchallenge.view.lianjinmm.LianjinMissionView", package.seeall)

local LianjinMissionView = class("LianjinMissionView", AthenaMissionView)

function LianjinMissionView:_getMainView()
	return ViewName.LianjinMainView
end

return LianjinMissionView
