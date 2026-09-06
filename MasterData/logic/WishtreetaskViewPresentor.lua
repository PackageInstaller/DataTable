-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/view/WishtreetaskViewPresentor.lua

module("logic.extensions.wishtree.view.WishtreetaskViewPresentor", package.seeall)

local WishtreetaskViewPresentor = class("WishtreetaskViewPresentor", ViewPresentor)

function WishtreetaskViewPresentor:ctor()
	WishtreetaskViewPresentor.super.ctor(self)
end

function WishtreetaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WishtreetaskViewPresentor:dependWhatResources()
	return {
		"ui/views/wishtree/wishtreetaskview.prefab"
	}
end

function WishtreetaskViewPresentor:buildViews()
	return {
		WishTreeTaskView.New()
	}
end

return WishtreetaskViewPresentor
