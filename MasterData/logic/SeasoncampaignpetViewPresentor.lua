-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasoncampaignpetViewPresentor.lua

module("logic.extensions.season.view.SeasoncampaignpetViewPresentor", package.seeall)

local SeasoncampaignpetViewPresentor = class("SeasoncampaignpetViewPresentor", ViewWithGuidePresentor)

function SeasoncampaignpetViewPresentor:ctor()
	SeasoncampaignpetViewPresentor.super.ctor(self)
end

function SeasoncampaignpetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasoncampaignpetViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasoncampaignpetview.prefab"
	}
end

function SeasoncampaignpetViewPresentor:buildViews()
	return {
		SeasoncampaignpetView.New()
	}
end

return SeasoncampaignpetViewPresentor
