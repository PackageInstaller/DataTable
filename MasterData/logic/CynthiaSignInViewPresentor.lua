-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/CynthiaSignInViewPresentor.lua

module("logic.extensions.operationsignin.view.CynthiaSignInViewPresentor", package.seeall)

local CynthiaSignInViewPresentor = class("CynthiaSignInViewPresentor", ViewPresentor)

function CynthiaSignInViewPresentor:ctor()
	CynthiaSignInViewPresentor.super.ctor(self)
end

function CynthiaSignInViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CynthiaSignInViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/operationsigninview.prefab"
	}
end

function CynthiaSignInViewPresentor:buildViews()
	return {
		CynthiaSignInView.New()
	}
end

return CynthiaSignInViewPresentor
