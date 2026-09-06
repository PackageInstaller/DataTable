-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKKnockout8PlayerViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKKnockout8PlayerViewPresentor", package.seeall)

local TCKKnockout8PlayerViewPresentor = class("TCKKnockout8PlayerViewPresentor", ViewPresentor)

function TCKKnockout8PlayerViewPresentor:ctor()
	TCKKnockout8PlayerViewPresentor.super.ctor(self)
end

function TCKKnockout8PlayerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKKnockout8PlayerViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckknockout8playerview.prefab"
	}
end

function TCKKnockout8PlayerViewPresentor:buildViews()
	return {
		TCKKnockout8PlayerView.New()
	}
end

function TCKKnockout8PlayerViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TCKKnockout8PlayerViewPresentor
