-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanshowViewPresentor.lua

module("logic.extensions.divinelongyan.view.DivinelongyanshowViewPresentor", package.seeall)

local DivinelongyanshowViewPresentor = class("DivinelongyanshowViewPresentor", ViewPresentor)

function DivinelongyanshowViewPresentor:ctor()
	DivinelongyanshowViewPresentor.super.ctor(self)
end

function DivinelongyanshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinelongyanshowViewPresentor:dependWhatResources()
	return {
		"ui/views/divinelongyan/divinelongyanshowview.prefab"
	}
end

function DivinelongyanshowViewPresentor:buildViews()
	return {
		DivinelongyanshowView.New()
	}
end

return DivinelongyanshowViewPresentor
