-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/CynthiamainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.Cynthia.CynthiamainViewPresentor", package.seeall)

local CynthiamainViewPresentor = class("CynthiamainViewPresentor", ViewPresentor)

function CynthiamainViewPresentor:ctor()
	CynthiamainViewPresentor.super.ctor(self)
end

function CynthiamainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CynthiamainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xinxiya/xinxiyamainview.prefab"
	}
end

function CynthiamainViewPresentor:buildViews()
	return {
		CynthiamainView.New()
	}
end

function CynthiamainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CynthiamainViewPresentor
