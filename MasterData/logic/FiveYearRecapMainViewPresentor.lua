-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapMainViewPresentor.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapMainViewPresentor", package.seeall)

local FiveYearRecapMainViewPresentor = class("FiveYearRecapMainViewPresentor", ViewPresentor)

function FiveYearRecapMainViewPresentor:ctor()
	FiveYearRecapMainViewPresentor.super.ctor(self)
end

function FiveYearRecapMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FiveYearRecapMainViewPresentor:dependWhatResources()
	return {
		"ui/views/fiveyearrecap/fiveyearrecapmainview.prefab"
	}
end

function FiveYearRecapMainViewPresentor:buildViews()
	return {
		FiveYearRecapMainView.New()
	}
end

return FiveYearRecapMainViewPresentor
