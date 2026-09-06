-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passwordlock/view/PasswordlockpreViewPresentor.lua

module("logic.extensions.passwordlock.view.PasswordlockpreViewPresentor", package.seeall)

local PasswordlockpreViewPresentor = class("PasswordlockpreViewPresentor", ViewPresentor)

function PasswordlockpreViewPresentor:ctor()
	PasswordlockpreViewPresentor.super.ctor(self)
end

function PasswordlockpreViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PasswordlockpreViewPresentor:dependWhatResources()
	return {
		"ui/views/passwordlock/passwordlockpreview.prefab"
	}
end

function PasswordlockpreViewPresentor:buildViews()
	return {
		PasswordlockpreView.New()
	}
end

return PasswordlockpreViewPresentor
