-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGameOverViewPresentor.lua

module("logic.extensions.linkgame.view.LinkGameOverViewPresentor", package.seeall)

local LinkGameOverViewPresentor = class("LinkGameOverViewPresentor", ViewPresentor)

function LinkGameOverViewPresentor:ctor()
	LinkGameOverViewPresentor.super.ctor(self)
end

function LinkGameOverViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LinkGameOverViewPresentor:dependWhatResources()
	return {
		"ui/views/linkgame/linkgameoverview.prefab"
	}
end

function LinkGameOverViewPresentor:buildViews()
	return {
		LinkGameOverView.New()
	}
end

return LinkGameOverViewPresentor
