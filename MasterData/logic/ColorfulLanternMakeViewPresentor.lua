-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/view/ColorfulLanternMakeViewPresentor.lua

module("logic.extensions.colorfullantern.view.ColorfulLanternMakeViewPresentor", package.seeall)

local ColorfulLanternMakeViewPresentor = class("ColorfulLanternMakeViewPresentor", ViewWithGuidePresentor)

function ColorfulLanternMakeViewPresentor:ctor()
	ColorfulLanternMakeViewPresentor.super.ctor(self)
end

function ColorfulLanternMakeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ColorfulLanternMakeViewPresentor:dependWhatResources()
	return {
		"ui/views/colorfullantern/colorfullanternmakeview.prefab"
	}
end

function ColorfulLanternMakeViewPresentor:buildViews()
	return {
		ColorfulLanternMakeView.New()
	}
end

return ColorfulLanternMakeViewPresentor
