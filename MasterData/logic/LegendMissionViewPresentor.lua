-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendMissionViewPresentor.lua

module("logic.extensions.legend.view.LegendMissionViewPresentor", package.seeall)

local LegendMissionViewPresentor = class("LegendMissionViewPresentor", MissionViewPresentor)

LegendMissionViewPresentor.SupportIcon = "ui/views/kingway/item_holychall.prefab"

function LegendMissionViewPresentor:ctor()
	LegendMissionViewPresentor.super.ctor(self)
end

function LegendMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LegendMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		LegendMissionViewPresentor.SupportIcon,
		self:_addCommonRes()
	}
end

function LegendMissionViewPresentor:buildViews()
	return {
		LegendMissionView.New(),
		LegendFormationRightView.New(),
		LegendFmtLeftView.New(),
		LegendMissionFmtView.New()
	}
end

function LegendMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LegendMissionViewPresentor
