-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/syguangmingwang/SyguangmingwangwitView.lua

module("logic.extensions.timelimitedchallenge.view.syguangmingwang.SyguangmingwangwitView", package.seeall)

local SyguangmingwangwitView = class("SyguangmingwangwitView", LianjinWitView)

function SyguangmingwangwitView:_getMissionView()
	return ViewName.SyguangmingwangMissionView
end

return SyguangmingwangwitView
