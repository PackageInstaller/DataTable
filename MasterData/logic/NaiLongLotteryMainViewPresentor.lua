-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/view/NaiLongLotteryMainViewPresentor.lua

module("logic.extensions.nailonglottery.view.NaiLongLotteryMainViewPresentor", package.seeall)

local NaiLongLotteryMainViewPresentor = class("NaiLongLotteryMainViewPresentor", ViewPresentor)

function NaiLongLotteryMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NaiLongLotteryMainViewPresentor:dependWhatResources()
	return {
		"ui/views/nailonglottery/nailonglotterymainview.prefab"
	}
end

function NaiLongLotteryMainViewPresentor:buildViews()
	return {
		NaiLongLotteryMainView.New()
	}
end

return NaiLongLotteryMainViewPresentor
