-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/dreamteammutualhelp/DreamteammutualhelpStageViewPresentor.lua

module("logic.extensions.scenariocopy.view.dreamteammutualhelp.DreamteammutualhelpStageViewPresentor", package.seeall)

local DreamteammutualhelpStageViewPresentor = class("DreamteammutualhelpStageViewPresentor", ViewPresentor)

function DreamteammutualhelpStageViewPresentor:ctor()
	DreamteammutualhelpStageViewPresentor.super.ctor(self)
end

function DreamteammutualhelpStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DreamteammutualhelpStageViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamyouth/dreamteamstageview.prefab"
	}
end

function DreamteammutualhelpStageViewPresentor:buildViews()
	return {
		DreamteammutualhelpStageView.New()
	}
end

return DreamteammutualhelpStageViewPresentor
