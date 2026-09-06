-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/view/EndlessDarkClgMainViewPresentor.lua

module("logic.extensions.endlessdark.view.EndlessDarkClgMainViewPresentor", package.seeall)

local EndlessDarkClgMainViewPresentor = class("EndlessDarkClgMainViewPresentor", ViewPresentor)

function EndlessDarkClgMainViewPresentor:ctor()
	EndlessDarkClgMainViewPresentor.super.ctor(self)
end

function EndlessDarkClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessDarkClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/endlessdarkclg/endlessdarkclgmainview.prefab"
	}
end

function EndlessDarkClgMainViewPresentor:buildViews()
	return {
		EndlessDarkClgMainView.New()
	}
end

return EndlessDarkClgMainViewPresentor
