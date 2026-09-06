-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passwordlock/view/PasswordlockmainViewPresentor.lua

module("logic.extensions.passwordlock.view.PasswordlockmainViewPresentor", package.seeall)

local PasswordlockmainViewPresentor = class("PasswordlockmainViewPresentor", ViewPresentor)

function PasswordlockmainViewPresentor:ctor()
	PasswordlockmainViewPresentor.super.ctor(self)
end

function PasswordlockmainViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PasswordlockmainViewPresentor:dependWhatResources()
	return {
		"ui/views/passwordlock/passwordlockmainview.prefab"
	}
end

function PasswordlockmainViewPresentor:buildViews()
	return {
		PasswordlockmainView.New()
	}
end

return PasswordlockmainViewPresentor
