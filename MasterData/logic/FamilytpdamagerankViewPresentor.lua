-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpdamagerankViewPresentor.lua

module("logic.extensions.familyteamplay.view.FamilytpdamagerankViewPresentor", package.seeall)

local FamilytpdamagerankViewPresentor = class("FamilytpdamagerankViewPresentor", ViewPresentor)

function FamilytpdamagerankViewPresentor:ctor()
	FamilytpdamagerankViewPresentor.super.ctor(self)
end

function FamilytpdamagerankViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilytpdamagerankViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytpdamagerankview.prefab"
	}
end

function FamilytpdamagerankViewPresentor:buildViews()
	return {
		FamilytpdamagerankView.New()
	}
end

return FamilytpdamagerankViewPresentor
