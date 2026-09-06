-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgExtViewPresentor.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgExtViewPresentor", package.seeall)

local DragonPsychicClgExtViewPresentor = class("DragonPsychicClgExtViewPresentor", ViewPresentor)

function DragonPsychicClgExtViewPresentor:ctor()
	DragonPsychicClgExtViewPresentor.super.ctor(self)
end

function DragonPsychicClgExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonPsychicClgExtViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonpsychicclg/dragonpsychicclgextview.prefab"
	}
end

function DragonPsychicClgExtViewPresentor:buildViews()
	return {
		DragonPsychicClgExtView.New()
	}
end

return DragonPsychicClgExtViewPresentor
