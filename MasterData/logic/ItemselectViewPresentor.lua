-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfareequiprecycle/view/ItemselectViewPresentor.lua

module("logic.extensions.welfareequiprecycle.view.ItemselectViewPresentor", package.seeall)

local ItemselectViewPresentor = class("ItemselectViewPresentor", ViewPresentor)

function ItemselectViewPresentor:ctor()
	ItemselectViewPresentor.super.ctor(self)
end

function ItemselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ItemselectViewPresentor:dependWhatResources()
	return {
		"ui/views/welfareequiprecycle/itemselectview.prefab"
	}
end

function ItemselectViewPresentor:buildViews()
	return {
		ItemselectView.New()
	}
end

return ItemselectViewPresentor
