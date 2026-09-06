-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgNorViewPresentor.lua

module("logic.extensions.wudiclg.view.WuDiClgNorViewPresentor", package.seeall)

local WuDiClgNorViewPresentor = class("WuDiClgNorViewPresentor", ViewPresentor)

function WuDiClgNorViewPresentor:ctor()
	WuDiClgNorViewPresentor.super.ctor(self)
end

function WuDiClgNorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WuDiClgNorViewPresentor:dependWhatResources()
	return {
		"ui/views/wudiclg/wudiclgnorview.prefab"
	}
end

function WuDiClgNorViewPresentor:buildViews()
	return {
		WuDiClgNorView.New()
	}
end

return WuDiClgNorViewPresentor
