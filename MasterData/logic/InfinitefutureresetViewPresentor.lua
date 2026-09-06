-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinitefutureresetViewPresentor.lua

module("logic.extensions.infinitefuture.view.InfinitefutureresetViewPresentor", package.seeall)

local InfinitefutureresetViewPresentor = class("InfinitefutureresetViewPresentor", ViewPresentor)

function InfinitefutureresetViewPresentor:ctor()
	InfinitefutureresetViewPresentor.super.ctor(self)
end

function InfinitefutureresetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function InfinitefutureresetViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/infinitefutureresetview.prefab"
	}
end

function InfinitefutureresetViewPresentor:buildViews()
	return {
		InfinitefutureresetView.New()
	}
end

return InfinitefutureresetViewPresentor
