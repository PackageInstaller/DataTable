-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiresolveViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamiresolveViewPresentor", package.seeall)

local HoshigamiresolveViewPresentor = class("HoshigamiresolveViewPresentor", ViewPresentor)

function HoshigamiresolveViewPresentor:ctor()
	HoshigamiresolveViewPresentor.super.ctor(self)
end

function HoshigamiresolveViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HoshigamiresolveViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamiresolveview.prefab"
	}
end

function HoshigamiresolveViewPresentor:buildViews()
	return {
		HoshigamiresolveView.New()
	}
end

return HoshigamiresolveViewPresentor
