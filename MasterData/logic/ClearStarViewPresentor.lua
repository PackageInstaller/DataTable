-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/view/ClearStarViewPresentor.lua

module("logic.extensions.clearstargame.view.ClearStarViewPresentor", package.seeall)

local ClearStarViewPresentor = class("ClearStarViewPresentor", ViewPresentor)

function ClearStarViewPresentor:ctor()
	ClearStarViewPresentor.super.ctor(self)
end

function ClearStarViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ClearStarViewPresentor:dependWhatResources()
	return {
		"ui/views/clearstar/clearstarview.prefab"
	}
end

function ClearStarViewPresentor:buildViews()
	return {
		ClearStarView.New()
	}
end

return ClearStarViewPresentor
