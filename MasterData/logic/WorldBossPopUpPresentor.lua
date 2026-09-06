-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossPopUpPresentor.lua

module("logic.extensions.worldboss.view.WorldBossPopUpPresentor", package.seeall)

local WorldBossPopUpPresentor = class("WorldBossPopUpPresentor", ViewPresentor)

function WorldBossPopUpPresentor:ctor()
	WorldBossPopUpPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PopupWindowViewPriority
end

function WorldBossPopUpPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldBossPopUpPresentor:dependWhatResources()
	return {
		"ui/views/worldboss/worldbosspopupview.prefab"
	}
end

function WorldBossPopUpPresentor:buildViews()
	return {
		WorldBossPopUpView.New()
	}
end

return WorldBossPopUpPresentor
