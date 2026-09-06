-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin4ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin4ViewPresentor", package.seeall)

local ExteriorOtherSkin4ViewPresentor = class("ExteriorOtherSkin4ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin4ViewPresentor:ctor()
	ExteriorOtherSkin4ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin4ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin4ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_4.prefab"
	}
end

function ExteriorOtherSkin4ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin4View.New()
	}
end

function ExteriorOtherSkin4ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin4ViewPresentor
