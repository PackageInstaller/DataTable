-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/syguangmingwang/SyguangmingwangMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.syguangmingwang.SyguangmingwangMissionViewPresentor", package.seeall)

local SyguangmingwangMissionViewPresentor = class("SyguangmingwangMissionViewPresentor", MissionViewPresentor)

function SyguangmingwangMissionViewPresentor:buildViews()
	return {
		SyguangmingwangMissionView.New(),
		LianjinFormationRightView.New(),
		LianjinFormationLeftView.New(),
		LianjinMissionFmtView.New()
	}
end

return SyguangmingwangMissionViewPresentor
