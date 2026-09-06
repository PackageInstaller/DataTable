-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin17ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin17ViewPresentor", package.seeall)

local ExteriorSkin17ViewPresentor = class("ExteriorSkin17ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin17ViewPresentor:ctor()
	ExteriorSkin17ViewPresentor.super.ctor(self)
end

function ExteriorSkin17ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin17ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_17.prefab"
	}
end

function ExteriorSkin17ViewPresentor:buildViews()
	return {
		ExteriorSkin17View.New()
	}
end

function ExteriorSkin17ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin17ViewPresentor
