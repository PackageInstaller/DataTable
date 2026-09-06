-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firework/view/FireworkprogressViewPresentor.lua

module("logic.extensions.firework.view.FireworkprogressViewPresentor", package.seeall)

local FireworkprogressViewPresentor = class("FireworkprogressViewPresentor", ViewPresentor)

function FireworkprogressViewPresentor:ctor()
	FireworkprogressViewPresentor.super.ctor(self)
end

function FireworkprogressViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FireworkprogressViewPresentor:dependWhatResources()
	return {
		"ui/views/firework/fireworkprogressview.prefab"
	}
end

function FireworkprogressViewPresentor:buildViews()
	return {
		FireworkprogressView.New()
	}
end

function FireworkprogressViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FireworkprogressViewPresentor
