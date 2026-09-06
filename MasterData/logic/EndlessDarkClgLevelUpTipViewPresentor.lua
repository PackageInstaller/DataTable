-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/view/EndlessDarkClgLevelUpTipViewPresentor.lua

module("logic.extensions.endlessdark.view.EndlessDarkClgLevelUpTipViewPresentor", package.seeall)

local EndlessDarkClgLevelUpTipViewPresentor = class("EndlessDarkClgLevelUpTipViewPresentor", ViewPresentor)

function EndlessDarkClgLevelUpTipViewPresentor:ctor()
	EndlessDarkClgLevelUpTipViewPresentor.super.ctor(self)
end

function EndlessDarkClgLevelUpTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessDarkClgLevelUpTipViewPresentor:dependWhatResources()
	return {
		"ui/views/endlessdarkclg/endlessdarkclgleveluptipview.prefab"
	}
end

function EndlessDarkClgLevelUpTipViewPresentor:buildViews()
	return {
		EndlessDarkClgLevelUpTipView.New()
	}
end

return EndlessDarkClgLevelUpTipViewPresentor
