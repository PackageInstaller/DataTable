-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpmainViewPresentor.lua

module("logic.extensions.familyteamplay.view.FamilytpmainViewPresentor", package.seeall)

local FamilytpmainViewPresentor = class("FamilytpmainViewPresentor", ViewPresentor)

function FamilytpmainViewPresentor:ctor()
	FamilytpmainViewPresentor.super.ctor(self)
end

function FamilytpmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilytpmainViewPresentor:dependWhatResources()
	return {
		"ui/views/familyteamplay/familytpmainview.prefab"
	}
end

function FamilytpmainViewPresentor:buildViews()
	return {
		FamilytpmainView.New()
	}
end

return FamilytpmainViewPresentor
