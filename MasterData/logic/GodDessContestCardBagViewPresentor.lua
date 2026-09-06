-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/card/GodDessContestCardBagViewPresentor.lua

module("logic.extensions.goddesscontest.view.card.GodDessContestCardBagViewPresentor", package.seeall)

local GodDessContestCardBagViewPresentor = class("GodDessContestCardBagViewPresentor", ViewPresentor)

function GodDessContestCardBagViewPresentor:ctor()
	GodDessContestCardBagViewPresentor.super.ctor(self)
end

function GodDessContestCardBagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDessContestCardBagViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/card/goddesscontestcardbagview.prefab"
	}
end

function GodDessContestCardBagViewPresentor:buildViews()
	return {
		GodDessContestCardBagView.New()
	}
end

return GodDessContestCardBagViewPresentor
