-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkFormationViewPresentor.lua

module("logic.extensions.pk.view.PkFormationViewPresentor", package.seeall)

local PkFormationViewPresentor = class("PkFormationViewPresentor", ViewPresentor)

function PkFormationViewPresentor:ctor()
	PkFormationViewPresentor.super.ctor(self)
end

function PkFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PkFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/pk/pkformationview.prefab"
	}
end

function PkFormationViewPresentor:buildViews()
	return {
		PkFormationLeftView.New(),
		PkformationRightView.New(),
		PkFormationView.New()
	}
end

return PkFormationViewPresentor
