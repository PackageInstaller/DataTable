-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/view/OriginTSDragonClgLevelViewPresentor.lua

module("logic.extensions.origintsdragonclg.view.OriginTSDragonClgLevelViewPresentor", package.seeall)

local OriginTSDragonClgLevelViewPresentor = class("OriginTSDragonClgLevelViewPresentor", ViewPresentor)

function OriginTSDragonClgLevelViewPresentor:ctor()
	OriginTSDragonClgLevelViewPresentor.super.ctor(self)
end

function OriginTSDragonClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginTSDragonClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/origintsdragonclg/origintsdragonclglevelview.prefab"
	}
end

function OriginTSDragonClgLevelViewPresentor:buildViews()
	return {
		OriginTSDragonClgLevelView.New()
	}
end

return OriginTSDragonClgLevelViewPresentor
