-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectingSkinViewPresentor.lua

module("logic.extensions.collectingskin.view.CollectingSkinViewPresentor", package.seeall)

local CollectingSkinViewPresentor = class("CollectingSkinViewPresentor", ViewPresentor)

function CollectingSkinViewPresentor:ctor()
	CollectingSkinViewPresentor.super.ctor(self)
end

function CollectingSkinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectingSkinViewPresentor:dependWhatResources()
	return {
		"ui/views/collectingskin/collectingskinview.prefab"
	}
end

function CollectingSkinViewPresentor:buildViews()
	return {
		CollectingSkinView.New()
	}
end

function CollectingSkinViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CollectingSkinViewPresentor
