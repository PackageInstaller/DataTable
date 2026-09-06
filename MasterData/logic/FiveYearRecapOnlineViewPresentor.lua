-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapOnlineViewPresentor.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapOnlineViewPresentor", package.seeall)

local FiveYearRecapOnlineViewPresentor = class("FiveYearRecapOnlineViewPresentor", ViewPresentor)

function FiveYearRecapOnlineViewPresentor:ctor()
	FiveYearRecapOnlineViewPresentor.super.ctor(self)
end

function FiveYearRecapOnlineViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FiveYearRecapOnlineViewPresentor:dependWhatResources()
	return {
		"ui/views/fiveyearrecap/fiveyearrecaponlineview.prefab"
	}
end

function FiveYearRecapOnlineViewPresentor:buildViews()
	return {
		FiveYearRecapOnlineView.New()
	}
end

function FiveYearRecapOnlineViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FiveYearRecapOnlineViewPresentor
