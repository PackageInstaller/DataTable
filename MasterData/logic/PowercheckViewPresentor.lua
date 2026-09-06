-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PowercheckViewPresentor.lua

module("logic.extensions.handbook.view.PowercheckViewPresentor", package.seeall)

local PowercheckViewPresentor = class("PowercheckViewPresentor", ViewPresentor)

function PowercheckViewPresentor:ctor()
	PowercheckViewPresentor.super.ctor(self)
end

function PowercheckViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowercheckViewPresentor:dependWhatResources()
	return {
		"ui/views/powercheck/powercheckview.prefab"
	}
end

function PowercheckViewPresentor:buildViews()
	return {
		PowercheckView.New()
	}
end

return PowercheckViewPresentor
