-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/EndlessdlotteryViewPresentor.lua

module("logic.extensions.infinitefuture.view.EndlessdlotteryViewPresentor", package.seeall)

local EndlessdlotteryViewPresentor = class("EndlessdlotteryViewPresentor", ViewPresentor)

function EndlessdlotteryViewPresentor:ctor()
	EndlessdlotteryViewPresentor.super.ctor(self)
end

function EndlessdlotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessdlotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/endlessdlotteryview.prefab"
	}
end

function EndlessdlotteryViewPresentor:buildViews()
	return {
		EndlessdlotteryView.New()
	}
end

return EndlessdlotteryViewPresentor
