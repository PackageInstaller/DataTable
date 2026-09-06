-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/view/FemalepsychiclevelViewPresentor.lua

module("logic.extensions.femalepsychic.view.FemalepsychiclevelViewPresentor", package.seeall)

local FemalepsychiclevelViewPresentor = class("FemalepsychiclevelViewPresentor", ViewPresentor)

function FemalepsychiclevelViewPresentor:ctor()
	FemalepsychiclevelViewPresentor.super.ctor(self)
end

function FemalepsychiclevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FemalepsychiclevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/femalepsychic/femalepsychiclevelview.prefab"
	}
end

function FemalepsychiclevelViewPresentor:buildViews()
	return {
		FemalePsychicLevelView.New()
	}
end

return FemalepsychiclevelViewPresentor
