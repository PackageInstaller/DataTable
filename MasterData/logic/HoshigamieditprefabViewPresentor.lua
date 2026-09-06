-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamieditprefabViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamieditprefabViewPresentor", package.seeall)

local HoshigamieditprefabViewPresentor = class("HoshigamieditprefabViewPresentor", ViewPresentor)

function HoshigamieditprefabViewPresentor:ctor()
	HoshigamieditprefabViewPresentor.super.ctor(self)
end

function HoshigamieditprefabViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HoshigamieditprefabViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamieditprefabview.prefab"
	}
end

function HoshigamieditprefabViewPresentor:buildViews()
	return {
		HoshigamieditprefabView.New()
	}
end

return HoshigamieditprefabViewPresentor
