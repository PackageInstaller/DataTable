-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/CustomFormationViewPresentor.lua

module("logic.extensions.customfmt.view.CustomFormationViewPresentor", package.seeall)

local CustomFormationViewPresentor = class("CustomFormationViewPresentor", MissionViewPresentor)

function CustomFormationViewPresentor:ctor()
	CustomFormationViewPresentor.super.ctor(self)
end

function CustomFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CustomFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationview.prefab"
	}
end

function CustomFormationViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function CustomFormationViewPresentor:buildViews()
	return {
		CustomFormationView.New(),
		CustomFmtRightView.New(),
		CustomFmtLeftView.New(),
		CustomFormTabView.New()
	}
end

return CustomFormationViewPresentor
