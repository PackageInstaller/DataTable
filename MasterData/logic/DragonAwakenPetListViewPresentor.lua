-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenPetListViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenPetListViewPresentor", package.seeall)

local DragonAwakenPetListViewPresentor = class("DragonAwakenPetListViewPresentor", ViewPresentor)

function DragonAwakenPetListViewPresentor:ctor()
	DragonAwakenPetListViewPresentor.super.ctor(self)
end

function DragonAwakenPetListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenPetListViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakenpetlistview.prefab"
	}
end

function DragonAwakenPetListViewPresentor:buildViews()
	return {
		DragonAwakenPetListView.New()
	}
end

return DragonAwakenPetListViewPresentor
