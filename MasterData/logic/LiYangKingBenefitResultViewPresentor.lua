-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingBenefitResultViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingBenefitResultViewPresentor", package.seeall)

local LiYangKingBenefitResultViewPresentor = class("LiYangKingBenefitResultViewPresentor", ViewPresentor)

function LiYangKingBenefitResultViewPresentor:ctor()
	LiYangKingBenefitResultViewPresentor.super.ctor(self)
end

function LiYangKingBenefitResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingBenefitResultViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkingbenefitresultview.prefab"
	}
end

function LiYangKingBenefitResultViewPresentor:buildViews()
	return {
		LiYangKingBenefitResultView.New()
	}
end

return LiYangKingBenefitResultViewPresentor
