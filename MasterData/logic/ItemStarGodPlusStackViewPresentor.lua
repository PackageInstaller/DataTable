-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/stack/ItemStarGodPlusStackViewPresentor.lua

module("logic.extensions.itembag.stack.ItemStarGodPlusStackViewPresentor", package.seeall)

local ItemStarGodPlusStackViewPresentor = class("ItemStarGodPlusStackViewPresentor", ViewPresentor)

function ItemStarGodPlusStackViewPresentor:ctor()
	ItemStarGodPlusStackViewPresentor.super.ctor(self)
end

function ItemStarGodPlusStackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ItemStarGodPlusStackViewPresentor:dependWhatResources()
	return {
		"ui/views/itembag/itemstargodplusstack.prefab"
	}
end

function ItemStarGodPlusStackViewPresentor:buildViews()
	return {
		ItemStarGodPlusStackView.New()
	}
end

function ItemStarGodPlusStackViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ItemStarGodPlusStackViewPresentor
