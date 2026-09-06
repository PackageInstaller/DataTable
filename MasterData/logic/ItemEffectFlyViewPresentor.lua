-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itemget/view/ItemEffectFlyViewPresentor.lua

module("logic.extensions.itemget.view.ItemEffectFlyViewPresentor", package.seeall)

local ItemEffectFlyViewPresentor = class("ItemEffectFlyViewPresentor", ViewPresentor)

function ItemEffectFlyViewPresentor:ctor()
	ItemEffectFlyViewPresentor.super.ctor(self)
end

function ItemEffectFlyViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function ItemEffectFlyViewPresentor:dependWhatResources()
	return {
		"ui/views/itemget/itemgeteffectfly.prefab"
	}
end

function ItemEffectFlyViewPresentor:buildViews()
	local views = {}
	local view = ItemEffectFlyView.New()

	table.insert(views, view)

	return views
end

return ItemEffectFlyViewPresentor
