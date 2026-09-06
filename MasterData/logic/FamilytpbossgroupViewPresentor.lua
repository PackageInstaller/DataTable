-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpbossgroupViewPresentor.lua

module("logic.extensions.familyteamplay.view.FamilytpbossgroupViewPresentor", package.seeall)

local FamilytpbossgroupViewPresentor = class("FamilytpbossgroupViewPresentor", ViewPresentor)

function FamilytpbossgroupViewPresentor:ctor()
	FamilytpbossgroupViewPresentor.super.ctor(self)
end

function FamilytpbossgroupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilytpbossgroupViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytpbossgroupview.prefab"
	}
end

function FamilytpbossgroupViewPresentor:buildViews()
	return {
		FamilytpbossgroupView.New()
	}
end

return FamilytpbossgroupViewPresentor
