-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/rank/PetTop5RankViewPresentor.lua

module("logic.extensions.handbook.view.rank.PetTop5RankViewPresentor", package.seeall)

local PetTop5RankViewPresentor = class("PetTop5RankViewPresentor", ViewPresentor)

function PetTop5RankViewPresentor:ctor()
	PetTop5RankViewPresentor.super.ctor(self)
end

function PetTop5RankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetTop5RankViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/lailisirankview.prefab"
	}
end

function PetTop5RankViewPresentor:buildViews()
	return {
		PetTop5RankView.New()
	}
end

return PetTop5RankViewPresentor
