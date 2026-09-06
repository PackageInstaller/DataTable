-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itemget/view/ItemGetFlyViewPresentor.lua

module("logic.extensions.itemget.view.ItemGetFlyViewPresentor", package.seeall)

local ItemGetFlyViewPresentor = class("ItemGetFlyViewPresentor", ViewPresentor)

function ItemGetFlyViewPresentor:ctor()
	ItemGetFlyViewPresentor.super.ctor(self)
end

function ItemGetFlyViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function ItemGetFlyViewPresentor:dependWhatResources()
	return {
		"ui/views/itemget/itemtipflyview.prefab"
	}
end

function ItemGetFlyViewPresentor:buildViews()
	local views = {}
	local view = ItemGetFlyView.New()

	table.insert(views, view)

	return views
end

function ItemGetFlyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ItemGetFlyViewPresentor
