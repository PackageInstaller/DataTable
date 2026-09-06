-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/view/DragonManClgStageViewPresentor.lua

module("logic.extensions.dragonmanclg.view.DragonManClgStageViewPresentor", package.seeall)

local DragonManClgStageViewPresentor = class("DragonManClgStageViewPresentor", ViewPresentor)

function DragonManClgStageViewPresentor:ctor()
	DragonManClgStageViewPresentor.super.ctor(self)
end

function DragonManClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonManClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonmanclg/dragonmanclgstageview.prefab"
	}
end

function DragonManClgStageViewPresentor:buildViews()
	return {
		DragonManClgStageView.New()
	}
end

return DragonManClgStageViewPresentor
