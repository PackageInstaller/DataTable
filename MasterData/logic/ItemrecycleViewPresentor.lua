-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/ItemrecycleViewPresentor.lua

module("logic.extensions.itembag.view.ItemrecycleViewPresentor", package.seeall)

local ItemrecycleViewPresentor = class("ItemrecycleViewPresentor", ViewPresentor)

function ItemrecycleViewPresentor:ctor()
	ItemrecycleViewPresentor.super.ctor(self)
end

function ItemrecycleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ItemrecycleViewPresentor:dependWhatResources()
	return {
		"ui/views/itembag/itemrecycleview.prefab"
	}
end

function ItemrecycleViewPresentor:buildViews()
	return {
		ItemrecycleView.New()
	}
end

return ItemrecycleViewPresentor
