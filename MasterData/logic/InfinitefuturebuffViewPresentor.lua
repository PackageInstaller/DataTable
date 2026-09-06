-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinitefuturebuffViewPresentor.lua

module("logic.extensions.infinitefuture.view.InfinitefuturebuffViewPresentor", package.seeall)

local InfinitefuturebuffViewPresentor = class("InfinitefuturebuffViewPresentor", ViewPresentor)

function InfinitefuturebuffViewPresentor:ctor()
	InfinitefuturebuffViewPresentor.super.ctor(self)
end

function InfinitefuturebuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function InfinitefuturebuffViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/infinitefuturebuffview.prefab"
	}
end

function InfinitefuturebuffViewPresentor:buildViews()
	return {
		InfinitefuturebuffView.New()
	}
end

return InfinitefuturebuffViewPresentor
