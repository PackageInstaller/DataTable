-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkagelottery/view/LinkageLotteryViewPresentor.lua

module("logic.extensions.linkagelottery.view.LinkageLotteryViewPresentor", package.seeall)

local LinkageLotteryViewPresentor = class("LinkageLotteryViewPresentor", ViewPresentor)

function LinkageLotteryViewPresentor:ctor()
	LinkageLotteryViewPresentor.super.ctor(self)
end

function LinkageLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkageLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/linkagelottery/linkagelotteryview.prefab"
	}
end

function LinkageLotteryViewPresentor:buildViews()
	return {
		LinkageLotteryView.New()
	}
end

return LinkageLotteryViewPresentor
