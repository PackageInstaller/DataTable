-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin25ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin25ViewPresentor", package.seeall)

local ExteriorSkin25ViewPresentor = class("ExteriorSkin25ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin25ViewPresentor:ctor()
	ExteriorSkin25ViewPresentor.super.ctor(self)
end

function ExteriorSkin25ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin25ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_25.prefab"
	}
end

function ExteriorSkin25ViewPresentor:buildViews()
	return {
		ExteriorSkin25View.New()
	}
end

function ExteriorSkin25ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin25ViewPresentor
