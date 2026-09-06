-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/PetSortPaneViewPresentor.lua

module("logic.extensions.bag.panel.PetSortPaneViewPresentor", package.seeall)

local PetSortPaneViewPresentor = class("PetSortPaneViewPresentor", ViewPresentor)

function PetSortPaneViewPresentor:ctor()
	PetSortPaneViewPresentor.super.ctor(self)
end

function PetSortPaneViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function PetSortPaneViewPresentor:dependWhatResources()
	return {
		"ui/views/common/pet_sortpane.prefab"
	}
end

function PetSortPaneViewPresentor:buildViews()
	return {
		PetSortPaneView.New()
	}
end

return PetSortPaneViewPresentor
