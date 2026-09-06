-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/ItemProcViewPresentor.lua

module("logic.extensions.material.view.ItemProcViewPresentor", package.seeall)

local ItemProcViewPresentor = class("ItemProcViewPresentor", ViewWithGuidePresentor)

function ItemProcViewPresentor:ctor()
	ItemProcViewPresentor.super.ctor(self)
end

function ItemProcViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ItemProcViewPresentor:dependWhatResources()
	return {
		"ui/views/itembag/itemprocview.prefab"
	}
end

function ItemProcViewPresentor:buildViews()
	local views = {}
	local view = ItemProcView.New()

	table.insert(views, view)

	return views
end

return ItemProcViewPresentor
