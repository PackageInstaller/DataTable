-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin4ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin4ViewPresentor", package.seeall)

local ExteriorSkin4ViewPresentor = class("ExteriorSkin4ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin4ViewPresentor:ctor()
	ExteriorSkin4ViewPresentor.super.ctor(self)
end

function ExteriorSkin4ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin4ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_4.prefab"
	}
end

function ExteriorSkin4ViewPresentor:buildViews()
	return {
		ExteriorSkin4View.New()
	}
end

function ExteriorSkin4ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin4ViewPresentor
