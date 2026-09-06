-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/view/DivinewatertianyanmainViewPresentor.lua

module("logic.extensions.divinewatertianyan.view.DivinewatertianyanmainViewPresentor", package.seeall)

local DivinewatertianyanmainViewPresentor = class("DivinewatertianyanmainViewPresentor", ViewPresentor)

function DivinewatertianyanmainViewPresentor:ctor()
	DivinewatertianyanmainViewPresentor.super.ctor(self)
end

function DivinewatertianyanmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinewatertianyanmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinewatertianyan/divinewatertianyanmainview.prefab"
	}
end

function DivinewatertianyanmainViewPresentor:buildViews()
	return {
		DivinewatertianyanmainView.New()
	}
end

return DivinewatertianyanmainViewPresentor
