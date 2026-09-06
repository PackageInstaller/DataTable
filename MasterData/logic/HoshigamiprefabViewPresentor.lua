-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiprefabViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamiprefabViewPresentor", package.seeall)

local HoshigamiprefabViewPresentor = class("HoshigamiprefabViewPresentor", ViewPresentor)

function HoshigamiprefabViewPresentor:ctor()
	HoshigamiprefabViewPresentor.super.ctor(self)
end

function HoshigamiprefabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HoshigamiprefabViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamiprefabview.prefab"
	}
end

function HoshigamiprefabViewPresentor:buildViews()
	return {
		HoshigamiprefabView.New()
	}
end

return HoshigamiprefabViewPresentor
