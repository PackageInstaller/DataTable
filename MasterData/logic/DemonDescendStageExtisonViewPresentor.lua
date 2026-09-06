-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/view/DemonDescendStageExtisonViewPresentor.lua

module("logic.extensions.demondescend.view.DemonDescendStageExtisonViewPresentor", package.seeall)

local DemonDescendStageExtisonViewPresentor = class("DemonDescendStageExtisonViewPresentor", ViewPresentor)

function DemonDescendStageExtisonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DemonDescendStageExtisonViewPresentor:dependWhatResources()
	return {
		"ui/views/demondescend/demondescendstageextisonview.prefab"
	}
end

function DemonDescendStageExtisonViewPresentor:buildViews()
	return {
		DemonDescendStageExtisonView.New()
	}
end

function DemonDescendStageExtisonViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DemonDescendStageExtisonViewPresentor
