-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpFinishResultViewPresentor.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpFinishResultViewPresentor", package.seeall)

local MagicSchoolPvpFinishResultViewPresentor = class("MagicSchoolPvpFinishResultViewPresentor", ViewPresentor)

function MagicSchoolPvpFinishResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolPvpFinishResultViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschoolpvp/magicschoolpvpfinishresultview.prefab"
	}
end

function MagicSchoolPvpFinishResultViewPresentor:buildViews()
	return {
		MagicSchoolPvpFinishResultView.New()
	}
end

return MagicSchoolPvpFinishResultViewPresentor
