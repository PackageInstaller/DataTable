-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/DivineLuciferResultViewPresentor.lua

module("logic.extensions.fantian.view.DivineLuciferResultViewPresentor", package.seeall)

local DivineLuciferResultViewPresentor = class("DivineLuciferResultViewPresentor", ViewPresentor)

function DivineLuciferResultViewPresentor:ctor()
	DivineLuciferResultViewPresentor.super.ctor(self)
end

function DivineLuciferResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineLuciferResultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fantian/divineluciferresultview.prefab"
	}
end

function DivineLuciferResultViewPresentor:buildViews()
	return {
		DivineLuciferResultView.New()
	}
end

return DivineLuciferResultViewPresentor
