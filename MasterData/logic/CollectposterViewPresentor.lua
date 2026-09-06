-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectposterViewPresentor.lua

module("logic.extensions.collectingskin.view.CollectposterViewPresentor", package.seeall)

local CollectposterViewPresentor = class("CollectposterViewPresentor", ViewPresentor)

function CollectposterViewPresentor:ctor()
	CollectposterViewPresentor.super.ctor(self)
end

function CollectposterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectposterViewPresentor:dependWhatResources()
	return {
		"ui/views/collectingskin/collectposterview.prefab"
	}
end

function CollectposterViewPresentor:buildViews()
	return {
		CollectposterView.New()
	}
end

function CollectposterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CollectposterViewPresentor
