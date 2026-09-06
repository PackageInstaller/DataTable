-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpReadyViewPresentor.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpReadyViewPresentor", package.seeall)

local MagicSchoolPvpReadyViewPresentor = class("MagicSchoolPvpReadyViewPresentor", ViewPresentor)

function MagicSchoolPvpReadyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolPvpReadyViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschoolpvp/magicschoolpvpreadyview.prefab"
	}
end

function MagicSchoolPvpReadyViewPresentor:buildViews()
	return {
		MagicSchoolPvpReadyView.New()
	}
end

return MagicSchoolPvpReadyViewPresentor
