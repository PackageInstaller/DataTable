-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpBattleResultViewPresentor.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpBattleResultViewPresentor", package.seeall)

local MagicSchoolPvpBattleResultViewPresentor = class("MagicSchoolPvpBattleResultViewPresentor", ViewPresentor)

function MagicSchoolPvpBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolPvpBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschoolpvp/magicschoolpvpbattleresultview.prefab"
	}
end

function MagicSchoolPvpBattleResultViewPresentor:buildViews()
	return {
		MagicSchoolPvpBattleResultView.New()
	}
end

return MagicSchoolPvpBattleResultViewPresentor
