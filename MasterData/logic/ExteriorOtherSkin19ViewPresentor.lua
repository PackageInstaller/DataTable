-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin19ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin19ViewPresentor", package.seeall)

local ExteriorOtherSkin19ViewPresentor = class("ExteriorOtherSkin19ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin19ViewPresentor:ctor()
	ExteriorOtherSkin19ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin19ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin19ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_19.prefab"
	}
end

function ExteriorOtherSkin19ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin19View.New()
	}
end

function ExteriorOtherSkin19ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin19ViewPresentor
