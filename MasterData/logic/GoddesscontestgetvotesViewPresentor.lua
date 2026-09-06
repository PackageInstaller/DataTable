-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddesscontestgetvotesViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddesscontestgetvotesViewPresentor", package.seeall)

local GoddesscontestgetvotesViewPresentor = class("GoddesscontestgetvotesViewPresentor", ViewPresentor)

function GoddesscontestgetvotesViewPresentor:ctor()
	GoddesscontestgetvotesViewPresentor.super.ctor(self)
end

function GoddesscontestgetvotesViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesscontestgetvotesViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestgetvotesview.prefab"
	}
end

function GoddesscontestgetvotesViewPresentor:buildViews()
	return {
		GoddessContestGetVotesView.New()
	}
end

return GoddesscontestgetvotesViewPresentor
