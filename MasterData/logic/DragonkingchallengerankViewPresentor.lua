-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonkingchallengerankViewPresentor.lua

module("logic.extensions.dragonking.view.DragonkingchallengerankViewPresentor", package.seeall)

local DragonkingchallengerankViewPresentor = class("DragonkingchallengerankViewPresentor", ViewPresentor)

function DragonkingchallengerankViewPresentor:ctor()
	DragonkingchallengerankViewPresentor.super.ctor(self)
end

function DragonkingchallengerankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonkingchallengerankViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/dragonking/dragonkingchallengerankview.prefab"
	}
end

function DragonkingchallengerankViewPresentor:buildViews()
	return {
		DragonkingchallengerankView.New()
	}
end

return DragonkingchallengerankViewPresentor
