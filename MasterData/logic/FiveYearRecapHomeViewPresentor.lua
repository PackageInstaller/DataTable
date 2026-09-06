-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapHomeViewPresentor.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapHomeViewPresentor", package.seeall)

local FiveYearRecapHomeViewPresentor = class("FiveYearRecapHomeViewPresentor", ViewPresentor)

function FiveYearRecapHomeViewPresentor:ctor()
	FiveYearRecapHomeViewPresentor.super.ctor(self)
end

function FiveYearRecapHomeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FiveYearRecapHomeViewPresentor:dependWhatResources()
	return {
		"ui/views/fiveyearrecap/fiveyearrecaphomeview.prefab"
	}
end

function FiveYearRecapHomeViewPresentor:buildViews()
	return {
		FiveYearRecapHomeView.New()
	}
end

function FiveYearRecapHomeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FiveYearRecapHomeViewPresentor
