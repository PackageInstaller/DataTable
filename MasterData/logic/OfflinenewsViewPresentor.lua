-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflinenewsViewPresentor.lua

module("logic.extensions.offline.view.OfflinenewsViewPresentor", package.seeall)

local OfflinenewsViewPresentor = class("OfflinenewsViewPresentor", ViewPresentor)

function OfflinenewsViewPresentor:ctor()
	OfflinenewsViewPresentor.super.ctor(self)
end

function OfflinenewsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OfflinenewsViewPresentor:dependWhatResources()
	return {
		"ui/views/offline/offlinenewsview.prefab"
	}
end

function OfflinenewsViewPresentor:buildViews()
	return {
		OfflinenewsView.New()
	}
end

return OfflinenewsViewPresentor
