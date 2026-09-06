-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/rank/PetRankPopViewPresentor.lua

module("logic.extensions.handbook.view.rank.PetRankPopViewPresentor", package.seeall)

local PetRankPopViewPresentor = class("PetRankPopViewPresentor", ViewPresentor)

function PetRankPopViewPresentor:ctor()
	PetRankPopViewPresentor.super.ctor(self)
end

function PetRankPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetRankPopViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/lailisirankpopview.prefab"
	}
end

function PetRankPopViewPresentor:buildViews()
	return {
		PetRankPopView.New()
	}
end

return PetRankPopViewPresentor
