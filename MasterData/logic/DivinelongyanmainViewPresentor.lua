-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanmainViewPresentor.lua

module("logic.extensions.divinelongyan.view.DivinelongyanmainViewPresentor", package.seeall)

local DivinelongyanmainViewPresentor = class("DivinelongyanmainViewPresentor", ViewPresentor)

function DivinelongyanmainViewPresentor:ctor()
	DivinelongyanmainViewPresentor.super.ctor(self)
end

function DivinelongyanmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinelongyanmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinelongyan/divinelongyanmainview.prefab"
	}
end

function DivinelongyanmainViewPresentor:buildViews()
	return {
		DivinelongyanmainView.New()
	}
end

return DivinelongyanmainViewPresentor
