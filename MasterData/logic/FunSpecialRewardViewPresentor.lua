-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunSpecialRewardViewPresentor.lua

module("logic.extensions.funarena.view.FunSpecialRewardViewPresentor", package.seeall)

local FunSpecialRewardViewPresentor = class("FunSpecialRewardViewPresentor", ViewPresentor)

function FunSpecialRewardViewPresentor:ctor()
	FunSpecialRewardViewPresentor.super.ctor(self)
end

function FunSpecialRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunSpecialRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/funarena/funspecialrewardview.prefab"
	}
end

function FunSpecialRewardViewPresentor:buildViews()
	return {
		FunSpecialRewardView.New()
	}
end

return FunSpecialRewardViewPresentor
