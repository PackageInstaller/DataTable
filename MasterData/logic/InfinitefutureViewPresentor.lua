-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinitefutureViewPresentor.lua

module("logic.extensions.infinitefuture.view.InfinitefutureViewPresentor", package.seeall)

local InfinitefutureViewPresentor = class("InfinitefutureViewPresentor", ViewPresentor)

function InfinitefutureViewPresentor:ctor()
	InfinitefutureViewPresentor.super.ctor(self)
end

function InfinitefutureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InfinitefutureViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/infinitefutureview.prefab"
	}
end

function InfinitefutureViewPresentor:buildViews()
	return {
		InfinitefutureView.New()
	}
end

return InfinitefutureViewPresentor
