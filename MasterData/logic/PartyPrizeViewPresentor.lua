-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partyprize/view/PartyPrizeViewPresentor.lua

module("logic.extensions.partyprize.view.PartyPrizeViewPresentor", package.seeall)

local PartyPrizeViewPresentor = class("PartyPrizeViewPresentor", ViewPresentor)

function PartyPrizeViewPresentor:ctor()
	PartyPrizeViewPresentor.super.ctor(self)
end

function PartyPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PartyPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/partyprize/partyprizeview.prefab"
	}
end

function PartyPrizeViewPresentor:buildViews()
	return {
		PartyPrizeView.New()
	}
end

return PartyPrizeViewPresentor
