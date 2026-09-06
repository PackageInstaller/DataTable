-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunLotteryViewPresentor.lua

module("logic.extensions.funarena.view.FunLotteryViewPresentor", package.seeall)

local FunLotteryViewPresentor = class("FunLotteryViewPresentor", ViewPresentor)

function FunLotteryViewPresentor:ctor()
	FunLotteryViewPresentor.super.ctor(self)
end

function FunLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/funarena/funlotteryview.prefab"
	}
end

function FunLotteryViewPresentor:getTempResources()
	return {
		GameUrl.getSpineUrl("30001_xunbao_gaotou")
	}
end

function FunLotteryViewPresentor:buildViews()
	return {
		FunLotteryView.New()
	}
end

return FunLotteryViewPresentor
