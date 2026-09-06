-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/stack/ItempetpiecestackPresentor.lua

module("logic.extensions.itembag.stack.ItempetpiecestackPresentor", package.seeall)

local ItempetpiecestackPresentor = class("ItempetpiecestackPresentor", ViewPresentor)

function ItempetpiecestackPresentor:ctor()
	ItempetpiecestackPresentor.super.ctor(self)
end

function ItempetpiecestackPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ItempetpiecestackPresentor:dependWhatResources()
	return {
		"ui/views/itembag/itempetpiecestack.prefab"
	}
end

function ItempetpiecestackPresentor:buildViews()
	return {
		ItempetpiecestackView.New()
	}
end

function ItempetpiecestackPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ItempetpiecestackPresentor
