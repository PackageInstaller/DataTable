-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardsignin/view/YearCardSignInBuyViewPresentor.lua

module("logic.extensions.yearcardsignin.view.YearCardSignInBuyViewPresentor", package.seeall)

local YearCardSignInBuyViewPresentor = class("YearCardSignInBuyViewPresentor", ViewPresentor)

function YearCardSignInBuyViewPresentor:ctor()
	YearCardSignInBuyViewPresentor.super.ctor(self)
end

function YearCardSignInBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSignInBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcardsignin/ycsigninbuyview.prefab"
	}
end

function YearCardSignInBuyViewPresentor:buildViews()
	return {
		YearcardSignInBuyView.New()
	}
end

function YearCardSignInBuyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YearCardSignInBuyViewPresentor
