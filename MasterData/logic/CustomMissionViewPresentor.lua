-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/CustomMissionViewPresentor.lua

module("logic.extensions.customfmt.view.CustomMissionViewPresentor", package.seeall)

local CustomMissionViewPresentor = class("CustomMissionViewPresentor", MissionViewPresentor)

function CustomMissionViewPresentor:ctor()
	CustomMissionViewPresentor.super.ctor(self)
end

function CustomMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CustomMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function CustomMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function CustomMissionViewPresentor:buildViews()
	return {
		CustomMissionView.New(),
		CustomFmtRightView.New(),
		CustomFmtLeftView.New(),
		CustomMissionFmtView.New(),
		CustomFormTabView.New()
	}
end

return CustomMissionViewPresentor
