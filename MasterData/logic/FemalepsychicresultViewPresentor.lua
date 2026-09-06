-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/view/FemalepsychicresultViewPresentor.lua

module("logic.extensions.femalepsychic.view.FemalepsychicresultViewPresentor", package.seeall)

local FemalepsychicresultViewPresentor = class("FemalepsychicresultViewPresentor", ViewPresentor)

function FemalepsychicresultViewPresentor:ctor()
	FemalepsychicresultViewPresentor.super.ctor(self)
end

function FemalepsychicresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FemalepsychicresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/femalepsychic/femalepsychicresultview.prefab"
	}
end

function FemalepsychicresultViewPresentor:buildViews()
	return {
		FemalePsychicResultView.New()
	}
end

return FemalepsychicresultViewPresentor
