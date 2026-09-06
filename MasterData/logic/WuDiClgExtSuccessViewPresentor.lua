-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgExtSuccessViewPresentor.lua

module("logic.extensions.wudiclg.view.WuDiClgExtSuccessViewPresentor", package.seeall)

local WuDiClgExtSuccessViewPresentor = class("WuDiClgExtSuccessViewPresentor", ViewPresentor)

function WuDiClgExtSuccessViewPresentor:ctor()
	WuDiClgExtSuccessViewPresentor.super.ctor(self)
end

function WuDiClgExtSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WuDiClgExtSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/wudiclg/wudiclgextsuccessview.prefab"
	}
end

function WuDiClgExtSuccessViewPresentor:buildViews()
	return {
		WuDiClgExtSuccessView.New()
	}
end

return WuDiClgExtSuccessViewPresentor
