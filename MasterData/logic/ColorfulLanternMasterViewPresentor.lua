-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/view/ColorfulLanternMasterViewPresentor.lua

module("logic.extensions.colorfullantern.view.ColorfulLanternMasterViewPresentor", package.seeall)

local ColorfulLanternMasterViewPresentor = class("ColorfulLanternMasterViewPresentor", ViewWithGuidePresentor)

function ColorfulLanternMasterViewPresentor:ctor()
	ColorfulLanternMasterViewPresentor.super.ctor(self)
end

function ColorfulLanternMasterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ColorfulLanternMasterViewPresentor:dependWhatResources()
	return {
		"ui/views/colorfullantern/colorfullanternmasterview.prefab"
	}
end

function ColorfulLanternMasterViewPresentor:buildViews()
	return {
		ColorfulLanternMasterView.New()
	}
end

return ColorfulLanternMasterViewPresentor
