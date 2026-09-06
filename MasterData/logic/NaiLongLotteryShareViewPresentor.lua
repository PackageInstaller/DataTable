-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/view/NaiLongLotteryShareViewPresentor.lua

module("logic.extensions.nailonglottery.view.NaiLongLotteryShareViewPresentor", package.seeall)

local NaiLongLotteryShareViewPresentor = class("NaiLongLotteryShareViewPresentor", ViewPresentor)

function NaiLongLotteryShareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NaiLongLotteryShareViewPresentor:dependWhatResources()
	return {
		"ui/views/nailonglottery/nailonglotteryshareview.prefab"
	}
end

function NaiLongLotteryShareViewPresentor:buildViews()
	return {
		NaiLongLotteryShareView.New()
	}
end

return NaiLongLotteryShareViewPresentor
