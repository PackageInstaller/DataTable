-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin18ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin18ViewPresentor", package.seeall)

local ExteriorSkin18ViewPresentor = class("ExteriorSkin18ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin18ViewPresentor:ctor()
	ExteriorSkin18ViewPresentor.super.ctor(self)
end

function ExteriorSkin18ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin18ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_18.prefab"
	}
end

function ExteriorSkin18ViewPresentor:buildViews()
	return {
		ExteriorSkin18View.New()
	}
end

function ExteriorSkin18ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin18ViewPresentor
