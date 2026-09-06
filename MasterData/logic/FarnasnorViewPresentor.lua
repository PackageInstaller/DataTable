-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasnorViewPresentor.lua

module("logic.extensions.farnas.view.FarnasnorViewPresentor", package.seeall)

local FarnasnorViewPresentor = class("FarnasnorViewPresentor", ViewPresentor)

function FarnasnorViewPresentor:ctor()
	FarnasnorViewPresentor.super.ctor(self)
end

function FarnasnorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FarnasnorViewPresentor:dependWhatResources()
	return {
		"ui/views/farnas/farnasnorview.prefab"
	}
end

function FarnasnorViewPresentor:buildViews()
	return {
		FarnasnorView.New()
	}
end

return FarnasnorViewPresentor
