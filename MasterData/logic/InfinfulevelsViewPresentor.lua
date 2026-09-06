-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfulevelsViewPresentor.lua

module("logic.extensions.infinitefuture.view.InfinfulevelsViewPresentor", package.seeall)

local InfinfulevelsViewPresentor = class("InfinfulevelsViewPresentor", ViewPresentor)

function InfinfulevelsViewPresentor:ctor()
	InfinfulevelsViewPresentor.super.ctor(self)
end

function InfinfulevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InfinfulevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/infinfulevelsview.prefab"
	}
end

function InfinfulevelsViewPresentor:buildViews()
	return {
		InfinfulevelsView.New()
	}
end

return InfinfulevelsViewPresentor
