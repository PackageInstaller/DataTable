-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgNormalEggViewPresentor.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgNormalEggViewPresentor", package.seeall)

local DragonPsychicClgNormalEggViewPresentor = class("DragonPsychicClgNormalEggViewPresentor", ViewPresentor)

function DragonPsychicClgNormalEggViewPresentor:ctor()
	DragonPsychicClgNormalEggViewPresentor.super.ctor(self)
end

function DragonPsychicClgNormalEggViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonPsychicClgNormalEggViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonpsychicclg/dragonpsychicclgnormaleggview.prefab"
	}
end

function DragonPsychicClgNormalEggViewPresentor:buildViews()
	return {
		DragonPsychicClgNormalEggView.New()
	}
end

return DragonPsychicClgNormalEggViewPresentor
