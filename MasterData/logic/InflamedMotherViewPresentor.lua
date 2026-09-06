-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InflamedMotherViewPresentor.lua

module("logic.extensions.infinitefuture.view.InflamedMotherViewPresentor", package.seeall)

local InflamedMotherViewPresentor = class("InflamedMotherViewPresentor", ViewPresentor)

function InflamedMotherViewPresentor:ctor()
	InflamedMotherViewPresentor.super.ctor(self)
end

function InflamedMotherViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InflamedMotherViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/inflamedmother/inflamedmotherview.prefab"
	}
end

function InflamedMotherViewPresentor:buildViews()
	return {
		InflamedMotherView.New()
	}
end

return InflamedMotherViewPresentor
