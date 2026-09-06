-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapPosterViewPresentor.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapPosterViewPresentor", package.seeall)

local FiveYearRecapPosterViewPresentor = class("FiveYearRecapPosterViewPresentor", ViewPresentor)

function FiveYearRecapPosterViewPresentor:ctor()
	FiveYearRecapPosterViewPresentor.super.ctor(self)
end

function FiveYearRecapPosterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FiveYearRecapPosterViewPresentor:dependWhatResources()
	return {
		"ui/views/fiveyearrecap/fiveyearrecapposterview.prefab"
	}
end

function FiveYearRecapPosterViewPresentor:buildViews()
	return {
		FiveYearRecapPosterView.New()
	}
end

function FiveYearRecapPosterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FiveYearRecapPosterViewPresentor
