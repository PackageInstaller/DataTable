-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin10ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin10ViewPresentor", package.seeall)

local ExteriorOtherSkin10ViewPresentor = class("ExteriorOtherSkin10ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin10ViewPresentor:ctor()
	ExteriorOtherSkin10ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin10ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin10ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_10.prefab"
	}
end

function ExteriorOtherSkin10ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin10View.New()
	}
end

function ExteriorOtherSkin10ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin10ViewPresentor
