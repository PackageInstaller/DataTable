-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/ItemMergeViewPresentor.lua

module("logic.extensions.material.view.ItemMergeViewPresentor", package.seeall)

local ItemMergeViewPresentor = class("ItemMergeViewPresentor", ViewPresentor)

function ItemMergeViewPresentor:ctor()
	ItemMergeViewPresentor.super.ctor(self)
end

function ItemMergeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ItemMergeViewPresentor:dependWhatResources()
	return {
		"ui/views/itembag/itemmergeview.prefab"
	}
end

function ItemMergeViewPresentor:buildViews()
	local views = {}
	local view = ItemMergeView.New()

	table.insert(views, view)

	return views
end

return ItemMergeViewPresentor
