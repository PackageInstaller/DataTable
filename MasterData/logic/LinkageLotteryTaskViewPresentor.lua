-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkagelottery/view/LinkageLotteryTaskViewPresentor.lua

module("logic.extensions.linkagelottery.view.LinkageLotteryTaskViewPresentor", package.seeall)

local LinkageLotteryTaskViewPresentor = class("LinkageLotteryTaskViewPresentor", ViewPresentor)

function LinkageLotteryTaskViewPresentor:ctor()
	LinkageLotteryTaskViewPresentor.super.ctor(self)
end

function LinkageLotteryTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkageLotteryTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/linkagelottery/linkagelotterytaskview.prefab"
	}
end

function LinkageLotteryTaskViewPresentor:buildViews()
	return {
		LinkageLotteryTaskView.New()
	}
end

return LinkageLotteryTaskViewPresentor
