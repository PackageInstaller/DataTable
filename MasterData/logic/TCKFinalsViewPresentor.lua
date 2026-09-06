-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKFinalsViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKFinalsViewPresentor", package.seeall)

local TCKFinalsViewPresentor = class("TCKFinalsViewPresentor", ViewPresentor)

function TCKFinalsViewPresentor:ctor()
	TCKFinalsViewPresentor.super.ctor(self)
end

function TCKFinalsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKFinalsViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckfinalsview.prefab"
	}
end

function TCKFinalsViewPresentor:buildViews()
	return {
		TCKFinalsView.New()
	}
end

function TCKFinalsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TCKFinalsViewPresentor
