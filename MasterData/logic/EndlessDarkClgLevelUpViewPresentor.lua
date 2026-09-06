-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/view/EndlessDarkClgLevelUpViewPresentor.lua

module("logic.extensions.endlessdark.view.EndlessDarkClgLevelUpViewPresentor", package.seeall)

local EndlessDarkClgLevelUpViewPresentor = class("EndlessDarkClgLevelUpViewPresentor", ViewPresentor)

function EndlessDarkClgLevelUpViewPresentor:ctor()
	EndlessDarkClgLevelUpViewPresentor.super.ctor(self)
end

function EndlessDarkClgLevelUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessDarkClgLevelUpViewPresentor:dependWhatResources()
	return {
		"ui/views/endlessdarkclg/endlessdarkclglevelupview.prefab"
	}
end

function EndlessDarkClgLevelUpViewPresentor:buildViews()
	return {
		EndlessDarkClgLevelUpView.New()
	}
end

return EndlessDarkClgLevelUpViewPresentor
