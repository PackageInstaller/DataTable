-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/ItemBagViewPresentor.lua

module("logic.extensions.itembag.view.ItemBagViewPresentor", package.seeall)

local ItemBagViewPresentor = class("ItemBagViewPresentor", ViewWithGuidePresentor)

function ItemBagViewPresentor:ctor()
	ItemBagViewPresentor.super.ctor(self)
end

function ItemBagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ItemBagViewPresentor:dependWhatResources()
	return {
		"ui/views/itembag/itembagview.prefab"
	}
end

function ItemBagViewPresentor:buildViews()
	local views = {}
	local view = ItemBagView.New()

	table.insert(views, view)

	return views
end

return ItemBagViewPresentor
