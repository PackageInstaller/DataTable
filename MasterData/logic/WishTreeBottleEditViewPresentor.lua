-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/view/WishTreeBottleEditViewPresentor.lua

module("logic.extensions.wishtreebottle.view.WishTreeBottleEditViewPresentor", package.seeall)

local WishTreeBottleEditViewPresentor = class("WishTreeBottleEditViewPresentor", ViewPresentor)

function WishTreeBottleEditViewPresentor:ctor()
	WishTreeBottleEditViewPresentor.super.ctor(self)
end

function WishTreeBottleEditViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WishTreeBottleEditViewPresentor:dependWhatResources()
	return {
		"ui/views/wishtreebottle/wishtreebottleeditview.prefab"
	}
end

function WishTreeBottleEditViewPresentor:buildViews()
	return {
		WishTreeBottleEditView.New()
	}
end

return WishTreeBottleEditViewPresentor
