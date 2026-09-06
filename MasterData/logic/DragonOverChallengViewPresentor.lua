-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonOverChallengViewPresentor.lua

module("logic.extensions.dragonlords.view.DragonOverChallengViewPresentor", package.seeall)

local DragonOverChallengViewPresentor = class("DragonOverChallengViewPresentor", ViewPresentor)

function DragonOverChallengViewPresentor:ctor()
	DragonOverChallengViewPresentor.super.ctor(self)
end

function DragonOverChallengViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonOverChallengViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/dragonlords/dragonoverchallengview.prefab"
	}
end

function DragonOverChallengViewPresentor:buildViews()
	return {
		DragonOverChallengView.New()
	}
end

return DragonOverChallengViewPresentor
