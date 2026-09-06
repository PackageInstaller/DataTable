-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgNormalViewPresentor.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgNormalViewPresentor", package.seeall)

local DragonPsychicClgNormalViewPresentor = class("DragonPsychicClgNormalViewPresentor", ViewPresentor)

function DragonPsychicClgNormalViewPresentor:ctor()
	DragonPsychicClgNormalViewPresentor.super.ctor(self)
end

function DragonPsychicClgNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonPsychicClgNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonpsychicclg/dragonpsychicclgnormalview.prefab"
	}
end

function DragonPsychicClgNormalViewPresentor:buildViews()
	return {
		DragonPsychicClgNormalView.New()
	}
end

return DragonPsychicClgNormalViewPresentor
