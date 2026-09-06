-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/DoubleElevenViewPresentor.lua

module("logic.extensions.doubleeleven.view.DoubleElevenViewPresentor", package.seeall)

local DoubleElevenViewPresentor = class("DoubleElevenViewPresentor", ViewPresentor)

function DoubleElevenViewPresentor:ctor()
	DoubleElevenViewPresentor.super.ctor(self)
end

function DoubleElevenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoubleElevenViewPresentor:dependWhatResources()
	return {
		"ui/views/doubleeleven/doubleelevenview.prefab"
	}
end

function DoubleElevenViewPresentor:buildViews()
	return {
		DoubleElevenView.New()
	}
end

return DoubleElevenViewPresentor
