-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingCostViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingCostViewPresentor", package.seeall)

local LiYangKingCostViewPresentor = class("LiYangKingCostViewPresentor", ViewPresentor)

function LiYangKingCostViewPresentor:ctor()
	LiYangKingCostViewPresentor.super.ctor(self)
end

function LiYangKingCostViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingCostViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkingcostview.prefab"
	}
end

function LiYangKingCostViewPresentor:buildViews()
	return {
		LiYangKingCostView.New()
	}
end

return LiYangKingCostViewPresentor
