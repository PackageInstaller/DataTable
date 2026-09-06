-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglifightViewPresentor.lua

module("logic.extensions.mimengli.view.MimenglifightViewPresentor", package.seeall)

local MimenglifightViewPresentor = class("MimenglifightViewPresentor", ViewPresentor)

function MimenglifightViewPresentor:ctor()
	MimenglifightViewPresentor.super.ctor(self)
end

function MimenglifightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MimenglifightViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mimengli/mimenglifightview.prefab"
	}
end

function MimenglifightViewPresentor:buildViews()
	return {
		MimenglifightView.New()
	}
end

function MimenglifightViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MimenglifightViewPresentor
