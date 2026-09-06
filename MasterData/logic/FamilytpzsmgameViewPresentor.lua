-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/zsm/FamilytpzsmgameViewPresentor.lua

module("logic.extensions.familyteamplay.view.game.zsm.FamilytpzsmgameViewPresentor", package.seeall)

local FamilytpzsmgameViewPresentor = class("FamilytpzsmgameViewPresentor", ViewPresentor)

function FamilytpzsmgameViewPresentor:ctor()
	FamilytpzsmgameViewPresentor.super.ctor(self)
end

function FamilytpzsmgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilytpzsmgameViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytpzsmgameview.prefab"
	}
end

function FamilytpzsmgameViewPresentor:buildViews()
	return {
		FamilytpzsmgameView.New()
	}
end

return FamilytpzsmgameViewPresentor
