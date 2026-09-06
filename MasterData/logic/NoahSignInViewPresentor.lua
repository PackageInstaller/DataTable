-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/NoahSignInViewPresentor.lua

module("logic.extensions.operationsignin.view.NoahSignInViewPresentor", package.seeall)

local NoahSignInViewPresentor = class("NoahSignInViewPresentor", ViewPresentor)

function NoahSignInViewPresentor:ctor()
	NoahSignInViewPresentor.super.ctor(self)
end

function NoahSignInViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NoahSignInViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/operationsigninview.prefab"
	}
end

function NoahSignInViewPresentor:buildViews()
	return {
		NoahSignInView.New()
	}
end

return NoahSignInViewPresentor
