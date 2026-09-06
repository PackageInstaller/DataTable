-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialmainViewPresentor.lua

module("logic.extensions.mirrortrial.view.MirrortrialmainViewPresentor", package.seeall)

local MirrortrialmainViewPresentor = class("MirrortrialmainViewPresentor", ViewPresentor)

function MirrortrialmainViewPresentor:ctor()
	MirrortrialmainViewPresentor.super.ctor(self)
end

function MirrortrialmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MirrortrialmainViewPresentor:dependWhatResources()
	return {
		"ui/views/mirrortrial/mirrortrialmainview.prefab"
	}
end

function MirrortrialmainViewPresentor:buildViews()
	return {
		MirrortrialmainView.New()
	}
end

function MirrortrialmainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MirrortrialmainViewPresentor
