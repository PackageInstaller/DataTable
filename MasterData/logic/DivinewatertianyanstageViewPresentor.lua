-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/view/DivinewatertianyanstageViewPresentor.lua

module("logic.extensions.divinewatertianyan.view.DivinewatertianyanstageViewPresentor", package.seeall)

local DivinewatertianyanstageViewPresentor = class("DivinewatertianyanstageViewPresentor", ViewPresentor)

function DivinewatertianyanstageViewPresentor:ctor()
	DivinewatertianyanstageViewPresentor.super.ctor(self)
end

function DivinewatertianyanstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinewatertianyanstageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinewatertianyan/divinewatertianyanstageview.prefab"
	}
end

function DivinewatertianyanstageViewPresentor:buildViews()
	return {
		DivinewatertianyanstageView.New()
	}
end

return DivinewatertianyanstageViewPresentor
