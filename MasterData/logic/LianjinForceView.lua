-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lianjinmm/LianjinForceView.lua

module("logic.extensions.timelimitedchallenge.view.lianjinmm.LianjinForceView", package.seeall)

local LianjinForceView = class("LianjinForceView", AthenaForceView)

function LianjinForceView:_getMissionView()
	return ViewName.LianjinMissionView
end

return LianjinForceView
