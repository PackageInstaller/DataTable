-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKQualifyViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKQualifyViewPresentor", package.seeall)

local TCKQualifyViewPresentor = class("TCKQualifyViewPresentor", ViewPresentor)

function TCKQualifyViewPresentor:ctor()
	TCKQualifyViewPresentor.super.ctor(self)
end

function TCKQualifyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKQualifyViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckqualifyview.prefab"
	}
end

function TCKQualifyViewPresentor:buildViews()
	return {
		TCKQualifyView.New()
	}
end

function TCKQualifyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TCKQualifyViewPresentor
