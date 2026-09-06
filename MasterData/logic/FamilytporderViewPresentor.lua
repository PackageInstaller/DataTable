-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytporderViewPresentor.lua

module("logic.extensions.familyteamplay.view.FamilytporderViewPresentor", package.seeall)

local FamilytporderViewPresentor = class("FamilytporderViewPresentor", ViewPresentor)

function FamilytporderViewPresentor:ctor()
	FamilytporderViewPresentor.super.ctor(self)
end

function FamilytporderViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilytporderViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytporderview.prefab"
	}
end

function FamilytporderViewPresentor:buildViews()
	return {
		FamilytporderView.New()
	}
end

return FamilytporderViewPresentor
