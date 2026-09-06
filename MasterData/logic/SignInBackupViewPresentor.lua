-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/SignInBackupViewPresentor.lua

module("logic.extensions.operationsignin.view.SignInBackupViewPresentor", package.seeall)

local SignInBackupViewPresentor = class("SignInBackupViewPresentor", ViewPresentor)

function SignInBackupViewPresentor:ctor()
	SignInBackupViewPresentor.super.ctor(self)
end

function SignInBackupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SignInBackupViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/signinbackupview.prefab"
	}
end

function SignInBackupViewPresentor:buildViews()
	return {
		SignInBackupView.New()
	}
end

return SignInBackupViewPresentor
