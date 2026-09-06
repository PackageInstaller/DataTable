-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/stack/ItemequipstackPresentor.lua

module("logic.extensions.itembag.stack.ItemequipstackPresentor", package.seeall)

local ItemequipstackPresentor = class("ItemequipstackPresentor", ViewPresentor)

function ItemequipstackPresentor:ctor()
	ItemequipstackPresentor.super.ctor(self)
end

function ItemequipstackPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ItemequipstackPresentor:dependWhatResources()
	return {
		"ui/views/itembag/itemequipstack.prefab"
	}
end

function ItemequipstackPresentor:buildViews()
	return {
		ItemequipstackView.New()
	}
end

function ItemequipstackPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ItemequipstackPresentor
