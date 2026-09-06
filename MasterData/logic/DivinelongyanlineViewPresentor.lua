-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanlineViewPresentor.lua

module("logic.extensions.divinelongyan.view.DivinelongyanlineViewPresentor", package.seeall)

local DivinelongyanlineViewPresentor = class("DivinelongyanlineViewPresentor", ViewPresentor)

function DivinelongyanlineViewPresentor:ctor()
	DivinelongyanlineViewPresentor.super.ctor(self)
end

function DivinelongyanlineViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinelongyanlineViewPresentor:dependWhatResources()
	return {
		"ui/views/divinelongyan/divinelongyanlineview.prefab"
	}
end

function DivinelongyanlineViewPresentor:buildViews()
	return {
		DivinelongyanlineView.New()
	}
end

return DivinelongyanlineViewPresentor
