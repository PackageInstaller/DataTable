-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareListViewPresentor.lua

module("logic.extensions.sharetask.view.ShareListViewPresentor", package.seeall)

local ShareListViewPresentor = class("ShareListViewPresentor", ViewPresentor)

function ShareListViewPresentor:ctor()
	ShareListViewPresentor.super.ctor(self)
end

function ShareListViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShareListViewPresentor:dependWhatResources()
	return {
		"ui/views/sharetask/sharelistview.prefab"
	}
end

function ShareListViewPresentor:buildViews()
	return {
		ShareListView.New()
	}
end

return ShareListViewPresentor
