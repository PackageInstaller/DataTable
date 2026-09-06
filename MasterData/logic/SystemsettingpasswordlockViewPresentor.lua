-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemsetting/view/SystemsettingpasswordlockViewPresentor.lua

module("logic.extensions.systemsetting.view.SystemsettingpasswordlockViewPresentor", package.seeall)

local SystemsettingpasswordlockViewPresentor = class("SystemsettingpasswordlockViewPresentor", ViewPresentor)

function SystemsettingpasswordlockViewPresentor:ctor()
	SystemsettingpasswordlockViewPresentor.super.ctor(self)
end

function SystemsettingpasswordlockViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SystemsettingpasswordlockViewPresentor:dependWhatResources()
	return {
		"ui/views/systemsetting/systemsettingpasswordlockview.prefab"
	}
end

function SystemsettingpasswordlockViewPresentor:buildViews()
	return {
		SystemsettingpasswordlockView.New()
	}
end

function SystemsettingpasswordlockViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SystemsettingpasswordlockViewPresentor
