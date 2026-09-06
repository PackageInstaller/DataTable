-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/SeniorFormationViewPresentor.lua

module("logic.extensions.formation.view.SeniorFormationViewPresentor", package.seeall)

local SeniorFormationViewPresentor = class("SeniorFormationViewPresentor", ViewPresentor)

function SeniorFormationViewPresentor:ctor()
	SeniorFormationViewPresentor.super.ctor(self)
end

function SeniorFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeniorFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationview.prefab"
	}
end

function SeniorFormationViewPresentor:buildViews()
	return {
		SeniorBuzhenLeftView.New(),
		SeniorFormationRightView.New(),
		SeniorFormationView.New(),
		SeniorFormTabView.New()
	}
end

return SeniorFormationViewPresentor
