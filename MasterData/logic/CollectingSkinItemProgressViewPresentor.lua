-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectingSkinItemProgressViewPresentor.lua

module("logic.extensions.collectingskin.view.CollectingSkinItemProgressViewPresentor", package.seeall)

local CollectingSkinItemProgressViewPresentor = class("CollectingSkinItemProgressViewPresentor", ViewPresentor)

function CollectingSkinItemProgressViewPresentor:ctor()
	CollectingSkinItemProgressViewPresentor.super.ctor(self)
end

function CollectingSkinItemProgressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectingSkinItemProgressViewPresentor:dependWhatResources()
	return {
		"ui/views/collectingskin/collectingskinitemprogressview.prefab"
	}
end

function CollectingSkinItemProgressViewPresentor:buildViews()
	return {
		CollectingSkinItemProgressView.New()
	}
end

function CollectingSkinItemProgressViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CollectingSkinItemProgressViewPresentor
