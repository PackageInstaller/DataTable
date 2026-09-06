-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAwakeListViewPresentor.lua

module("logic.extensions.bag.view.stack.PetAwakeListViewPresentor", package.seeall)

local PetAwakeListViewPresentor = class("PetAwakeListViewPresentor", ViewPresentor)

function PetAwakeListViewPresentor:ctor()
	PetAwakeListViewPresentor.super.ctor(self)
end

function PetAwakeListViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetAwakeListViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petawakelistview.prefab"
	}
end

function PetAwakeListViewPresentor:buildViews()
	return {
		PetAwakeListView.New()
	}
end

return PetAwakeListViewPresentor
