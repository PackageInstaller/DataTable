-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/stack/ItemstargodstackPresentor.lua

module("logic.extensions.itembag.stack.ItemstargodstackPresentor", package.seeall)

local ItemstargodstackPresentor = class("ItemstargodstackPresentor", ViewPresentor)

function ItemstargodstackPresentor:ctor()
	ItemstargodstackPresentor.super.ctor(self)
end

function ItemstargodstackPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ItemstargodstackPresentor:dependWhatResources()
	return {
		"ui/views/itembag/itemstargodstack.prefab"
	}
end

function ItemstargodstackPresentor:buildViews()
	return {
		ItemstargodstackView.New()
	}
end

function ItemstargodstackPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ItemstargodstackPresentor
