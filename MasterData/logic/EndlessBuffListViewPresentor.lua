-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/view/EndlessBuffListViewPresentor.lua

module("logic.extensions.endlessbattle.view.EndlessBuffListViewPresentor", package.seeall)

local EndlessBuffListViewPresentor = class("EndlessBuffListViewPresentor", ViewPresentor)

function EndlessBuffListViewPresentor:ctor()
	EndlessBuffListViewPresentor.super.ctor(self)
end

function EndlessBuffListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessBuffListViewPresentor:dependWhatResources()
	return {
		"ui/views/endlessbattle/endlessbufflistview.prefab"
	}
end

function EndlessBuffListViewPresentor:buildViews()
	return {
		EndlessBuffListView.New()
	}
end

return EndlessBuffListViewPresentor
