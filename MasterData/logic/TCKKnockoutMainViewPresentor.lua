-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKKnockoutMainViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKKnockoutMainViewPresentor", package.seeall)

local TCKKnockoutMainViewPresentor = class("TCKKnockoutMainViewPresentor", ViewPresentor)

function TCKKnockoutMainViewPresentor:ctor()
	TCKKnockoutMainViewPresentor.super.ctor(self)
end

function TCKKnockoutMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKKnockoutMainViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckknockoutmainview.prefab"
	}
end

function TCKKnockoutMainViewPresentor:buildViews()
	return {
		TCKKnockoutMainView.New()
	}
end

function TCKKnockoutMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TCKKnockoutMainViewPresentor
