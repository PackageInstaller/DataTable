-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/dreamteammutualhelp/DreamteammutualhelpViewPresentor.lua

module("logic.extensions.scenariocopy.view.dreamteammutualhelp.DreamteammutualhelpViewPresentor", package.seeall)

local DreamteammutualhelpViewPresentor = class("DreamteammutualhelpViewPresentor", ViewPresentor)

function DreamteammutualhelpViewPresentor:ctor()
	DreamteammutualhelpViewPresentor.super.ctor(self)
end

function DreamteammutualhelpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamteammutualhelpViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamyouth/dreamteamcopyview.prefab"
	}
end

function DreamteammutualhelpViewPresentor:buildViews()
	return {
		DreamteammutualhelpView.New()
	}
end

return DreamteammutualhelpViewPresentor
