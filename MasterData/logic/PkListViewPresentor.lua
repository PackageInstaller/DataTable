-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkListViewPresentor.lua

module("logic.extensions.pk.view.PkListViewPresentor", package.seeall)

local PkListViewPresentor = class("PkListViewPresentor", ViewPresentor)

function PkListViewPresentor:ctor()
	PkListViewPresentor.super.ctor(self)
end

function PkListViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PkListViewPresentor:dependWhatResources()
	return {
		"ui/views/pk/pklistview.prefab"
	}
end

function PkListViewPresentor:buildViews()
	return {
		PkListView.New()
	}
end

return PkListViewPresentor
