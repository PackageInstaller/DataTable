-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/view/DivinehopestageViewPresentor.lua

module("logic.extensions.divinehope.view.DivinehopestageViewPresentor", package.seeall)

local DivinehopestageViewPresentor = class("DivinehopestageViewPresentor", ViewPresentor)

function DivinehopestageViewPresentor:ctor()
	DivinehopestageViewPresentor.super.ctor(self)
end

function DivinehopestageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinehopestageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinehope/divinehopestageview.prefab"
	}
end

function DivinehopestageViewPresentor:buildViews()
	return {
		DivinehopestageView.New()
	}
end

return DivinehopestageViewPresentor
