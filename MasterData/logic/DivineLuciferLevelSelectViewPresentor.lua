-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/DivineLuciferLevelSelectViewPresentor.lua

module("logic.extensions.fantian.view.DivineLuciferLevelSelectViewPresentor", package.seeall)

local DivineLuciferLevelSelectViewPresentor = class("DivineLuciferLevelSelectViewPresentor", ViewPresentor)

function DivineLuciferLevelSelectViewPresentor:ctor()
	DivineLuciferLevelSelectViewPresentor.super.ctor(self)
end

function DivineLuciferLevelSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineLuciferLevelSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fantian/divineluciferlevelselectview.prefab"
	}
end

function DivineLuciferLevelSelectViewPresentor:buildViews()
	return {
		DivineLuciferLevelSelectView.New()
	}
end

return DivineLuciferLevelSelectViewPresentor
