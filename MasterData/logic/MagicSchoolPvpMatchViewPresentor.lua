-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpMatchViewPresentor.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpMatchViewPresentor", package.seeall)

local MagicSchoolPvpMatchViewPresentor = class("MagicSchoolPvpMatchViewPresentor", ViewPresentor)

function MagicSchoolPvpMatchViewPresentor:ctor()
	MagicSchoolPvpMatchViewPresentor.super.ctor(self)
end

function MagicSchoolPvpMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolPvpMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschoolpvp/magicschoolpvpmatchview.prefab"
	}
end

function MagicSchoolPvpMatchViewPresentor:buildViews()
	return {
		MagicSchoolPvpMatchView.New()
	}
end

return MagicSchoolPvpMatchViewPresentor
