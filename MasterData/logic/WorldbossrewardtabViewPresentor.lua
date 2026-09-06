-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldbossrewardtabViewPresentor.lua

module("logic.extensions.worldboss.view.WorldbossrewardtabViewPresentor", package.seeall)

local WorldbossrewardtabViewPresentor = class("WorldbossrewardtabViewPresentor", ViewPresentor)

function WorldbossrewardtabViewPresentor:ctor()
	WorldbossrewardtabViewPresentor.super.ctor(self)
end

function WorldbossrewardtabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldbossrewardtabViewPresentor:dependWhatResources()
	return {
		"ui/views/worldboss/worldbossrewardtabview.prefab"
	}
end

function WorldbossrewardtabViewPresentor:buildViews()
	return {
		WorldbossrewardtabView.New()
	}
end

return WorldbossrewardtabViewPresentor
