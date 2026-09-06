-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/view/DivinehopeselectViewPresentor.lua

module("logic.extensions.divinehope.view.DivinehopeselectViewPresentor", package.seeall)

local DivinehopeselectViewPresentor = class("DivinehopeselectViewPresentor", ViewPresentor)

function DivinehopeselectViewPresentor:ctor()
	DivinehopeselectViewPresentor.super.ctor(self)
end

function DivinehopeselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinehopeselectViewPresentor:dependWhatResources()
	return {
		"ui/views/divinehope/divinehopeselectview.prefab"
	}
end

function DivinehopeselectViewPresentor:buildViews()
	return {
		DivinehopeselectView.New()
	}
end

return DivinehopeselectViewPresentor
