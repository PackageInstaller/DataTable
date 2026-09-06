-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoofriendlistViewPresentor.lua

module("logic.extensions.zoo.view.ZoofriendlistViewPresentor", package.seeall)

local ZoofriendlistViewPresentor = class("ZoofriendlistViewPresentor", ViewPresentor)

function ZoofriendlistViewPresentor:ctor()
	ZoofriendlistViewPresentor.super.ctor(self)
end

function ZoofriendlistViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZoofriendlistViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoofriendlistview.prefab"
	}
end

function ZoofriendlistViewPresentor:buildViews()
	return {
		ZooFriendListView.New()
	}
end

return ZoofriendlistViewPresentor
