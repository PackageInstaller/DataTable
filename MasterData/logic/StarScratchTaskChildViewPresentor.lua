-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starscratch/view/StarScratchTaskChildViewPresentor.lua

module("logic.extensions.starscratch.view.StarScratchTaskChildViewPresentor", package.seeall)

local StarScratchTaskChildViewPresentor = class("StarScratchTaskChildViewPresentor", ViewPresentor)

function StarScratchTaskChildViewPresentor:ctor()
	StarScratchTaskChildViewPresentor.super.ctor(self)
end

function StarScratchTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarScratchTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/starscratch/starscratchtaskchildview.prefab"
	}
end

function StarScratchTaskChildViewPresentor:buildViews()
	return {
		StarScratchTaskChildView.New()
	}
end

function StarScratchTaskChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StarScratchTaskChildViewPresentor
