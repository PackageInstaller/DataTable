-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/view/EndlessDarkClgRankViewPresentor.lua

module("logic.extensions.endlessdark.view.EndlessDarkClgRankViewPresentor", package.seeall)

local EndlessDarkClgRankViewPresentor = class("EndlessDarkClgRankViewPresentor", ViewPresentor)

function EndlessDarkClgRankViewPresentor:ctor()
	EndlessDarkClgRankViewPresentor.super.ctor(self)
end

function EndlessDarkClgRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessDarkClgRankViewPresentor:dependWhatResources()
	return {
		"ui/views/endlessdarkclg/endlessdarkclgrankview.prefab"
	}
end

function EndlessDarkClgRankViewPresentor:buildViews()
	return {
		EndlessDarkClgRankView.New()
	}
end

return EndlessDarkClgRankViewPresentor
