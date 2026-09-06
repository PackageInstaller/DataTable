-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpBuffViewPresentor.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpBuffViewPresentor", package.seeall)

local MagicSchoolPvpBuffViewPresentor = class("MagicSchoolPvpBuffViewPresentor", ViewPresentor)

function MagicSchoolPvpBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MagicSchoolPvpBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschoolpvp/magicschoolpvpbuffview.prefab"
	}
end

function MagicSchoolPvpBuffViewPresentor:buildViews()
	return {
		MagicSchoolPvpBuffView.New()
	}
end

return MagicSchoolPvpBuffViewPresentor
