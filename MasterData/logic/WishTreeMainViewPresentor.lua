-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/view/WishTreeMainViewPresentor.lua

module("logic.extensions.wishtree.view.WishTreeMainViewPresentor", package.seeall)

local WishTreeMainViewPresentor = class("WishTreeMainViewPresentor", ViewPresentor)

function WishTreeMainViewPresentor:ctor()
	WishTreeMainViewPresentor.super.ctor(self)
end

function WishTreeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WishTreeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/wishtree/wishtreemainview.prefab"
	}
end

function WishTreeMainViewPresentor:buildViews()
	return {
		WishTreeMainView.New()
	}
end

return WishTreeMainViewPresentor
