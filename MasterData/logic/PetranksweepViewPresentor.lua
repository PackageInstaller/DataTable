-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetranksweepViewPresentor.lua

module("logic.extensions.handbook.view.PetranksweepViewPresentor", package.seeall)

local PetranksweepViewPresentor = class("PetranksweepViewPresentor", ViewPresentor)

function PetranksweepViewPresentor:ctor()
	PetranksweepViewPresentor.super.ctor(self)
end

function PetranksweepViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetranksweepViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/petranksweepview.prefab"
	}
end

function PetranksweepViewPresentor:buildViews()
	return {
		PetranksweepView.New()
	}
end

return PetranksweepViewPresentor
