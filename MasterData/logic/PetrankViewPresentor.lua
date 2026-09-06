-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/rank/PetrankViewPresentor.lua

module("logic.extensions.handbook.view.rank.PetrankViewPresentor", package.seeall)

local PetrankViewPresentor = class("PetrankViewPresentor", ViewPresentor)

function PetrankViewPresentor:ctor()
	PetrankViewPresentor.super.ctor(self)
end

function PetrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetrankViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/petrankview.prefab"
	}
end

function PetrankViewPresentor:buildViews()
	return {
		PetRankView.New()
	}
end

return PetrankViewPresentor
