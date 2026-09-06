-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InflamedlotteryViewPresentor.lua

module("logic.extensions.infinitefuture.view.InflamedlotteryViewPresentor", package.seeall)

local InflamedlotteryViewPresentor = class("InflamedlotteryViewPresentor", ViewPresentor)

function InflamedlotteryViewPresentor:ctor()
	InflamedlotteryViewPresentor.super.ctor(self)
end

function InflamedlotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InflamedlotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/inflamedmother/inflamedlotteryview.prefab"
	}
end

function InflamedlotteryViewPresentor:buildViews()
	return {
		InflamedlotteryView.New()
	}
end

return InflamedlotteryViewPresentor
