-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/syguangmingwang/SyguangmingwangforceView.lua

module("logic.extensions.timelimitedchallenge.view.syguangmingwang.SyguangmingwangforceView", package.seeall)

local SyguangmingwangforceView = class("SyguangmingwangforceView", LianjinForceView)

function SyguangmingwangforceView:_getMissionView()
	return ViewName.SyguangmingwangMissionView
end

return SyguangmingwangforceView
