-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/stack/ItemstackPresentor.lua

module("logic.extensions.itembag.stack.ItemstackPresentor", package.seeall)

local ItemstackPresentor = class("ItemstackPresentor", ViewPresentor)

function ItemstackPresentor:ctor()
	ItemstackPresentor.super.ctor(self)
end

function ItemstackPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ItemstackPresentor:dependWhatResources()
	return {
		"ui/views/itembag/itemstack.prefab"
	}
end

function ItemstackPresentor:buildViews()
	return {
		ItemstackView.New()
	}
end

function ItemstackPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ItemstackPresentor
