-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin24ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin24ViewPresentor", package.seeall)

local ExteriorSkin24ViewPresentor = class("ExteriorSkin24ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin24ViewPresentor:ctor()
	ExteriorSkin24ViewPresentor.super.ctor(self)
end

function ExteriorSkin24ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin24ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_24.prefab"
	}
end

function ExteriorSkin24ViewPresentor:buildViews()
	return {
		ExteriorSkin24View.New()
	}
end

function ExteriorSkin24ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin24ViewPresentor
