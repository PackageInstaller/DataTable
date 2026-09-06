-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/publiccardpool/PublicDragonLotteryPresentor.lua

module("logic.extensions.lottery.view.publiccardpool.PublicDragonLotteryPresentor", package.seeall)

local PublicDragonLotteryPresentor = class("PublicDragonLotteryPresentor", ViewPresentor)

function PublicDragonLotteryPresentor:ctor()
	PublicDragonLotteryPresentor.super.ctor(self)
end

function PublicDragonLotteryPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PublicDragonLotteryPresentor:dependWhatResources()
	return {
		"ui/views/publicdragonlottery/publicdragonlotteryview.prefab"
	}
end

function PublicDragonLotteryPresentor:buildViews()
	return {
		PublicDragonLottery.New()
	}
end

return PublicDragonLotteryPresentor
