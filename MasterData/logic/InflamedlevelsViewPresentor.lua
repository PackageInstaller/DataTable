-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InflamedlevelsViewPresentor.lua

module("logic.extensions.infinitefuture.view.InflamedlevelsViewPresentor", package.seeall)

local InflamedlevelsViewPresentor = class("InflamedlevelsViewPresentor", ViewPresentor)

function InflamedlevelsViewPresentor:ctor()
	InflamedlevelsViewPresentor.super.ctor(self)
end

function InflamedlevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InflamedlevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/inflamedmother/inflamedlevelsview.prefab"
	}
end

function InflamedlevelsViewPresentor:buildViews()
	return {
		InflamedlevelsView.New()
	}
end

return InflamedlevelsViewPresentor
