-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/MatResSweepViewPresentor.lua

module("logic.extensions.bag.view.MatResSweepViewPresentor", package.seeall)

local MatResSweepViewPresentor = class("MatResSweepViewPresentor", ViewPresentor)

function MatResSweepViewPresentor:ctor()
	MatResSweepViewPresentor.super.ctor(self)
end

function MatResSweepViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MatResSweepViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/matressweepview.prefab"
	}
end

function MatResSweepViewPresentor:buildViews()
	return {
		MatResSweepView.New()
	}
end

function MatResSweepViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MatResSweepViewPresentor
