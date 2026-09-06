-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgMainViewPresentor.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgMainViewPresentor", package.seeall)

local DragonPsychicClgMainViewPresentor = class("DragonPsychicClgMainViewPresentor", ViewPresentor)

function DragonPsychicClgMainViewPresentor:ctor()
	DragonPsychicClgMainViewPresentor.super.ctor(self)
end

function DragonPsychicClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonPsychicClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonpsychicclg/dragonpsychicclgmainview.prefab"
	}
end

function DragonPsychicClgMainViewPresentor:buildViews()
	return {
		DragonPsychicClgMainView.New()
	}
end

return DragonPsychicClgMainViewPresentor
