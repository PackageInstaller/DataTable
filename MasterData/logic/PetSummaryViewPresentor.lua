-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetSummaryViewPresentor.lua

module("logic.extensions.recommendfmt.view.PetSummaryViewPresentor", package.seeall)

local PetSummaryViewPresentor = class("PetSummaryViewPresentor", ViewPresentor)

function PetSummaryViewPresentor:ctor()
	PetSummaryViewPresentor.super.ctor(self)
end

function PetSummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetSummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/recommendfmt/petsummaryview.prefab"
	}
end

function PetSummaryViewPresentor:buildViews()
	return {
		PetSummaryView.New()
	}
end

return PetSummaryViewPresentor
