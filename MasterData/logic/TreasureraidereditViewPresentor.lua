-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidereditViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraidereditViewPresentor", package.seeall)

local TreasureraidereditViewPresentor = class("TreasureraidereditViewPresentor", ViewPresentor)

function TreasureraidereditViewPresentor:ctor()
	TreasureraidereditViewPresentor.super.ctor(self)
end

function TreasureraidereditViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraidereditViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraidereditview.prefab"
	}
end

function TreasureraidereditViewPresentor:buildViews()
	return {
		TreasureraidereditView.New()
	}
end

function TreasureraidereditViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TreasureraidereditViewPresentor
