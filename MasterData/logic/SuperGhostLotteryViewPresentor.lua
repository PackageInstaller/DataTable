-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/superghostlottery/view/SuperGhostLotteryViewPresentor.lua

module("logic.extensions.superghostlottery.view.SuperGhostLotteryViewPresentor", package.seeall)

local SuperGhostLotteryViewPresentor = class("SuperGhostLotteryViewPresentor", ViewPresentor)

function SuperGhostLotteryViewPresentor:ctor()
	SuperGhostLotteryViewPresentor.super.ctor(self)
end

function SuperGhostLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SuperGhostLotteryViewPresentor:dependWhatResources()
	if self:getFirstParam() == 1 then
		-- block empty
	end

	return {
		"ui/views/superghostlottery/superghostlotteryview.prefab"
	}
end

function SuperGhostLotteryViewPresentor:buildViews()
	return {
		SuperGhostLotteryView.New()
	}
end

return SuperGhostLotteryViewPresentor
