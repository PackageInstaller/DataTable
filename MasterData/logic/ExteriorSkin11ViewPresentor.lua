-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin11ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin11ViewPresentor", package.seeall)

local ExteriorSkin11ViewPresentor = class("ExteriorSkin11ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin11ViewPresentor:ctor()
	ExteriorSkin11ViewPresentor.super.ctor(self)
end

function ExteriorSkin11ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin11ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_11.prefab"
	}
end

function ExteriorSkin11ViewPresentor:buildViews()
	return {
		ExteriorSkin11View.New()
	}
end

function ExteriorSkin11ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin11ViewPresentor
