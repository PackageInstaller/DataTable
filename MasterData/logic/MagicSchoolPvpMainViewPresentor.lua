-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpMainViewPresentor.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpMainViewPresentor", package.seeall)

local MagicSchoolPvpMainViewPresentor = class("MagicSchoolPvpMainViewPresentor", ViewPresentor)

function MagicSchoolPvpMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolPvpMainViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschoolpvp/magicschoolpvpmainview.prefab"
	}
end

function MagicSchoolPvpMainViewPresentor:buildViews()
	return {
		MagicSchoolPvpMainView.New()
	}
end

return MagicSchoolPvpMainViewPresentor
