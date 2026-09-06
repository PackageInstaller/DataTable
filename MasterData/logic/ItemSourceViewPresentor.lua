-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/ItemSourceViewPresentor.lua

module("logic.extensions.material.view.ItemSourceViewPresentor", package.seeall)

local ItemSourceViewPresentor = class("ItemSourceViewPresentor", ViewWithGuidePresentor)

function ItemSourceViewPresentor:ctor()
	ItemSourceViewPresentor.super.ctor(self)
end

function ItemSourceViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ItemSourceViewPresentor:dependWhatResources()
	return {
		"ui/views/itembag/itemsourceview.prefab"
	}
end

function ItemSourceViewPresentor:buildViews()
	local views = {}
	local view = ItemSourceView.New()

	table.insert(views, view)

	return views
end

return ItemSourceViewPresentor
