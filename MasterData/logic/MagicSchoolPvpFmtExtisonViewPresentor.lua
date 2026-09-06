-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpFmtExtisonViewPresentor.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpFmtExtisonViewPresentor", package.seeall)

local MagicSchoolPvpFmtExtisonViewPresentor = class("MagicSchoolPvpFmtExtisonViewPresentor", ViewPresentor)

function MagicSchoolPvpFmtExtisonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicSchoolPvpFmtExtisonViewPresentor:dependWhatResources()
	return {
		"ui/views/magicschoolpvp/magicschoolpvpfmtextisonview.prefab"
	}
end

function MagicSchoolPvpFmtExtisonViewPresentor:buildViews()
	return {
		MagicSchoolPvpFmtExtisonView.New()
	}
end

function MagicSchoolPvpFmtExtisonViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MagicSchoolPvpFmtExtisonViewPresentor
