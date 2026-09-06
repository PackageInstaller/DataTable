-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/view/WishtreelistViewPresentor.lua

module("logic.extensions.wishtree.view.WishtreelistViewPresentor", package.seeall)

local WishtreelistViewPresentor = class("WishtreelistViewPresentor", ViewPresentor)

function WishtreelistViewPresentor:ctor()
	WishtreelistViewPresentor.super.ctor(self)
end

function WishtreelistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WishtreelistViewPresentor:dependWhatResources()
	return {
		"ui/views/wishtree/wishtreelistview.prefab"
	}
end

function WishtreelistViewPresentor:buildViews()
	return {
		WishTreeListView.New()
	}
end

return WishtreelistViewPresentor
