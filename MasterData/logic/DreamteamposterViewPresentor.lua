-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/grandceremony/DreamteamposterViewPresentor.lua

module("logic.extensions.bonus.view.grandceremony.DreamteamposterViewPresentor", package.seeall)

local DreamteamposterViewPresentor = class("DreamteamposterViewPresentor", ViewPresentor)

function DreamteamposterViewPresentor:ctor()
	DreamteamposterViewPresentor.super.ctor(self)
end

function DreamteamposterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamteamposterViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/grandceremony/dreamteamposterview.prefab"
	}
end

function DreamteamposterViewPresentor:buildViews()
	return {
		DreamteamposterView.New()
	}
end

return DreamteamposterViewPresentor
