-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lianjinmm/LianjinWitView.lua

module("logic.extensions.timelimitedchallenge.view.lianjinmm.LianjinWitView", package.seeall)

local LianjinWitView = class("LianjinWitView", AthenaWitView)

function LianjinWitView:_getMissionView()
	return ViewName.LianjinMissionView
end

return LianjinWitView
