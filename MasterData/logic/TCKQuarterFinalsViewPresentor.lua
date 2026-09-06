-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKQuarterFinalsViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKQuarterFinalsViewPresentor", package.seeall)

local TCKQuarterFinalsViewPresentor = class("TCKQuarterFinalsViewPresentor", ViewPresentor)

function TCKQuarterFinalsViewPresentor:ctor()
	TCKQuarterFinalsViewPresentor.super.ctor(self)
end

function TCKQuarterFinalsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKQuarterFinalsViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckquarterfinalsview.prefab"
	}
end

function TCKQuarterFinalsViewPresentor:buildViews()
	return {
		TCKQuarterFinalsView.New()
	}
end

function TCKQuarterFinalsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TCKQuarterFinalsViewPresentor
