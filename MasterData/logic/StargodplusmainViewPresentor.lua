-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplusmainViewPresentor.lua

module("logic.extensions.stargodplus.view.StargodplusmainViewPresentor", package.seeall)

local StargodplusmainViewPresentor = class("StargodplusmainViewPresentor", ViewWithGuidePresentor)

function StargodplusmainViewPresentor:ctor()
	StargodplusmainViewPresentor.super.ctor(self)
end

function StargodplusmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StargodplusmainViewPresentor:dependWhatResources()
	return {
		"ui/views/stargodplus/stargodplusmainview.prefab"
	}
end

function StargodplusmainViewPresentor:buildViews()
	return {
		StargodplusmainView.New()
	}
end

function StargodplusmainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StargodplusmainViewPresentor
