-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/NoahSignInPopupViewPresentor.lua

module("logic.extensions.operationsignin.view.NoahSignInPopupViewPresentor", package.seeall)

local NoahSignInPopupViewPresentor = class("NoahSignInPopupViewPresentor", ViewPresentor)

function NoahSignInPopupViewPresentor:ctor()
	NoahSignInPopupViewPresentor.super.ctor(self)
end

function NoahSignInPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NoahSignInPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/signinpopupview.prefab"
	}
end

function NoahSignInPopupViewPresentor:buildViews()
	return {
		NoahSignInPopupView.New()
	}
end

return NoahSignInPopupViewPresentor
