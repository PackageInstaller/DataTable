-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidersceneViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraidersceneViewPresentor", package.seeall)

local TreasureraidersceneViewPresentor = class("TreasureraidersceneViewPresentor", ViewWithGuidePresentor)

function TreasureraidersceneViewPresentor:ctor()
	TreasureraidersceneViewPresentor.super.ctor(self)
end

function TreasureraidersceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraidersceneViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraidersceneview.prefab"
	}
end

function TreasureraidersceneViewPresentor:buildViews()
	return {
		TreasureraidersceneView.New()
	}
end

function TreasureraidersceneViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TreasureraidersceneViewPresentor
