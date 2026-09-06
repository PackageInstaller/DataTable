-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfulotteryViewPresentor.lua

module("logic.extensions.infinitefuture.view.InfinfulotteryViewPresentor", package.seeall)

local InfinfulotteryViewPresentor = class("InfinfulotteryViewPresentor", ViewPresentor)

function InfinfulotteryViewPresentor:ctor()
	InfinfulotteryViewPresentor.super.ctor(self)
end

function InfinfulotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InfinfulotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/infinfulotteryview.prefab"
	}
end

function InfinfulotteryViewPresentor:buildViews()
	return {
		InfinfulotteryView.New()
	}
end

return InfinfulotteryViewPresentor
