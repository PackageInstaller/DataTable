-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/view/ClearStarGameResultViewPresentor.lua

module("logic.extensions.clearstargame.view.ClearStarGameResultViewPresentor", package.seeall)

local ClearStarGameResultViewPresentor = class("ClearStarGameResultViewPresentor", ViewPresentor)

function ClearStarGameResultViewPresentor:ctor()
	ClearStarGameResultViewPresentor.super.ctor(self)
end

function ClearStarGameResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ClearStarGameResultViewPresentor:dependWhatResources()
	return {
		"ui/views/clearstar/clearstargameresultview.prefab"
	}
end

function ClearStarGameResultViewPresentor:buildViews()
	return {
		ClearStarGameResultView.New()
	}
end

return ClearStarGameResultViewPresentor
