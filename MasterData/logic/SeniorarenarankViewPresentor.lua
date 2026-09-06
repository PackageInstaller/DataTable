-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showoff/view/SeniorarenarankViewPresentor.lua

module("logic.extensions.showoff.view.SeniorarenarankViewPresentor", package.seeall)

local SeniorarenarankViewPresentor = class("SeniorarenarankViewPresentor", ViewPresentor)

function SeniorarenarankViewPresentor:ctor()
	SeniorarenarankViewPresentor.super.ctor(self)
end

function SeniorarenarankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeniorarenarankViewPresentor:dependWhatResources()
	return {
		"ui/views/showoff/seniorarenarankview.prefab"
	}
end

function SeniorarenarankViewPresentor:buildViews()
	return {
		SeniorarenarankView.New()
	}
end

function SeniorarenarankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeniorarenarankViewPresentor
