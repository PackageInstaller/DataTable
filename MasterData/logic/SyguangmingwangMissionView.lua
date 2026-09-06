-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/syguangmingwang/SyguangmingwangMissionView.lua

module("logic.extensions.timelimitedchallenge.view.syguangmingwang.SyguangmingwangMissionView", package.seeall)

local SyguangmingwangMissionView = class("SyguangmingwangMissionView", AthenaMissionView)

function SyguangmingwangMissionView:_getMainView()
	return ViewName.SyguangmingwangmainView
end

return SyguangmingwangMissionView
