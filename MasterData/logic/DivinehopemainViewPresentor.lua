-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/view/DivinehopemainViewPresentor.lua

module("logic.extensions.divinehope.view.DivinehopemainViewPresentor", package.seeall)

local DivinehopemainViewPresentor = class("DivinehopemainViewPresentor", ViewPresentor)

function DivinehopemainViewPresentor:ctor()
	DivinehopemainViewPresentor.super.ctor(self)
end

function DivinehopemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinehopemainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinehope/divinehopemainview.prefab"
	}
end

function DivinehopemainViewPresentor:buildViews()
	return {
		DivinehopemainView.New()
	}
end

return DivinehopemainViewPresentor
