-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin8ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin8ViewPresentor", package.seeall)

local ExteriorSkin8ViewPresentor = class("ExteriorSkin8ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin8ViewPresentor:ctor()
	ExteriorSkin8ViewPresentor.super.ctor(self)
end

function ExteriorSkin8ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin8ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_8.prefab"
	}
end

function ExteriorSkin8ViewPresentor:buildViews()
	return {
		ExteriorSkin8View.New()
	}
end

function ExteriorSkin8ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin8ViewPresentor
