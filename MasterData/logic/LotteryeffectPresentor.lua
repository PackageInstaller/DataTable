-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryeffectPresentor.lua

module("logic.extensions.lottery.view.LotteryeffectPresentor", package.seeall)

local LotteryeffectPresentor = class("LotteryeffectPresentor", ViewPresentor)

function LotteryeffectPresentor:ctor()
	LotteryeffectPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.LotteryEffectViewPriority
end

function LotteryeffectPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotteryeffectPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotteryeffectview.prefab"
	}
end

function LotteryeffectPresentor:buildViews()
	return {
		LotteryeffectView.New()
	}
end

function LotteryeffectPresentor:getTempResources()
	return {
		"effect/prefabs/ui/fx_chouka/fx_chouka_tongyong.prefab",
		"effect/prefabs/ui/fx_chouka/shichou/baise.prefab",
		"effect/prefabs/ui/fx_chouka/shichou/lanse.prefab",
		"effect/prefabs/ui/fx_chouka/shichou/zise.prefab",
		"effect/prefabs/ui/fx_chouka/shichou/jinse.prefab",
		"effect/prefabs/ui/fx_chouka/shichou/baise_tuowei.prefab",
		"effect/prefabs/ui/fx_chouka/shichou/lanse_tuowei.prefab",
		"effect/prefabs/ui/fx_chouka/shichou/zise_tuowei.prefab",
		"effect/prefabs/ui/fx_chouka/shichou/jinse_tuowei.prefab"
	}
end

function LotteryeffectPresentor:closeCallBack()
	return
end

return LotteryeffectPresentor
