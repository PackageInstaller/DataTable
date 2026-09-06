-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/kjt/FamilytpkrzgameViewPresentor.lua

module("logic.extensions.familyteamplay.view.game.kjt.FamilytpkrzgameViewPresentor", package.seeall)

local FamilytpkrzgameViewPresentor = class("FamilytpkrzgameViewPresentor", ViewPresentor)

function FamilytpkrzgameViewPresentor:ctor()
	FamilytpkrzgameViewPresentor.super.ctor(self)
end

function FamilytpkrzgameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilytpkrzgameViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytpkrzgameview.prefab",
		"character/30011_ui_jitui/30011_ui_jitui_p.prefab"
	}
end

function FamilytpkrzgameViewPresentor:buildViews()
	return {
		FamilytpkrzgameView.New()
	}
end

return FamilytpkrzgameViewPresentor
