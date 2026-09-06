-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origineternaldragonclg/view/OriginEternalDragonClgLevelViewPresentor.lua

module("logic.extensions.origineternaldragonclg.view.OriginEternalDragonClgLevelViewPresentor", package.seeall)

local OriginEternalDragonClgLevelViewPresentor = class("OriginEternalDragonClgLevelViewPresentor", ViewPresentor)

function OriginEternalDragonClgLevelViewPresentor:ctor()
	OriginEternalDragonClgLevelViewPresentor.super.ctor(self)
end

function OriginEternalDragonClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginEternalDragonClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/origineternaldragonclg/origineternaldragonclglevelview.prefab"
	}
end

function OriginEternalDragonClgLevelViewPresentor:buildViews()
	return {
		OriginEternalDragonClgLevelView.New()
	}
end

return OriginEternalDragonClgLevelViewPresentor
