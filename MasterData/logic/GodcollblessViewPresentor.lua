-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GodcollblessViewPresentor.lua

module("logic.extensions.goddesscollector.view.GodcollblessViewPresentor", package.seeall)

local GodcollblessViewPresentor = class("GodcollblessViewPresentor", ViewPresentor)

function GodcollblessViewPresentor:ctor()
	GodcollblessViewPresentor.super.ctor(self)
end

function GodcollblessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodcollblessViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscollector/godcollblessview.prefab"
	}
end

function GodcollblessViewPresentor:buildViews()
	return {
		GodcollblessView.New()
	}
end

return GodcollblessViewPresentor
