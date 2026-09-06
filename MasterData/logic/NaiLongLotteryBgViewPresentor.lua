-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/view/NaiLongLotteryBgViewPresentor.lua

module("logic.extensions.nailonglottery.view.NaiLongLotteryBgViewPresentor", package.seeall)

local NaiLongLotteryBgViewPresentor = class("NaiLongLotteryBgViewPresentor", ViewPresentor)

function NaiLongLotteryBgViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NaiLongLotteryBgViewPresentor:dependWhatResources()
	return {
		"ui/views/nailonglottery/nailonglotterybgview.prefab"
	}
end

function NaiLongLotteryBgViewPresentor:buildViews()
	return {
		NaiLongLotteryBgView.New()
	}
end

return NaiLongLotteryBgViewPresentor
