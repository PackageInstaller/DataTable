-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgNormalEggSuccessViewPresentor.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgNormalEggSuccessViewPresentor", package.seeall)

local DragonPsychicClgNormalEggSuccessViewPresentor = class("DragonPsychicClgNormalEggSuccessViewPresentor", ViewPresentor)

function DragonPsychicClgNormalEggSuccessViewPresentor:ctor()
	DragonPsychicClgNormalEggSuccessViewPresentor.super.ctor(self)
end

function DragonPsychicClgNormalEggSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonPsychicClgNormalEggSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonpsychicclg/dragonpsychicclgnormaleggsuccessview.prefab"
	}
end

function DragonPsychicClgNormalEggSuccessViewPresentor:buildViews()
	return {
		DragonPsychicClgNormalEggSuccessView.New()
	}
end

return DragonPsychicClgNormalEggSuccessViewPresentor
