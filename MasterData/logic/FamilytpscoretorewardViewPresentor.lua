-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/FamilytpscoretorewardViewPresentor.lua

module("logic.extensions.familyteamplay.view.game.FamilytpscoretorewardViewPresentor", package.seeall)

local FamilytpscoretorewardViewPresentor = class("FamilytpscoretorewardViewPresentor", ViewPresentor)

function FamilytpscoretorewardViewPresentor:ctor()
	FamilytpscoretorewardViewPresentor.super.ctor(self)
end

function FamilytpscoretorewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilytpscoretorewardViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytpscoretorewardview.prefab"
	}
end

function FamilytpscoretorewardViewPresentor:buildViews()
	return {
		FamilytpscoretorewardView.New()
	}
end

function FamilytpscoretorewardViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return FamilytpscoretorewardViewPresentor
