-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/view/NaiLongLotteryPlayViewPresentor.lua

module("logic.extensions.nailonglottery.view.NaiLongLotteryPlayViewPresentor", package.seeall)

local NaiLongLotteryPlayViewPresentor = class("NaiLongLotteryPlayViewPresentor", ViewPresentor)

function NaiLongLotteryPlayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NaiLongLotteryPlayViewPresentor:dependWhatResources()
	return {
		"ui/views/nailonglottery/nailonglotteryplayview.prefab"
	}
end

function NaiLongLotteryPlayViewPresentor:buildViews()
	return {
		NaiLongLotteryPlayView.New()
	}
end

return NaiLongLotteryPlayViewPresentor
