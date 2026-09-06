-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/SaifulotteryViewPresentor.lua

module("logic.extensions.infinitefuture.view.SaifulotteryViewPresentor", package.seeall)

local SaifulotteryViewPresentor = class("SaifulotteryViewPresentor", ViewPresentor)

function SaifulotteryViewPresentor:ctor()
	SaifulotteryViewPresentor.super.ctor(self)
end

function SaifulotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaifulotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/saifulotteryview.prefab"
	}
end

function SaifulotteryViewPresentor:buildViews()
	return {
		SaifulotteryView.New()
	}
end

return SaifulotteryViewPresentor
