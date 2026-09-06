-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpRankViewPresentor.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpRankViewPresentor", package.seeall)

local MagicSchoolPvpRankViewPresentor = class("MagicSchoolPvpRankViewPresentor", ViewPresentor)

function MagicSchoolPvpRankViewPresentor:ctor()
	MagicSchoolPvpRankViewPresentor.super.ctor(self)
end

function MagicSchoolPvpRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolPvpRankViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschoolpvp/magicschoolpvprankview.prefab"
	}
end

function MagicSchoolPvpRankViewPresentor:buildViews()
	return {
		MagicSchoolPvpRankView.New()
	}
end

return MagicSchoolPvpRankViewPresentor
