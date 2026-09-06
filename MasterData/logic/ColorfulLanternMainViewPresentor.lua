-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/view/ColorfulLanternMainViewPresentor.lua

module("logic.extensions.colorfullantern.view.ColorfulLanternMainViewPresentor", package.seeall)

local ColorfulLanternMainViewPresentor = class("ColorfulLanternMainViewPresentor", ViewWithGuidePresentor)

function ColorfulLanternMainViewPresentor:ctor()
	ColorfulLanternMainViewPresentor.super.ctor(self)
end

function ColorfulLanternMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ColorfulLanternMainViewPresentor:dependWhatResources()
	return {
		"ui/views/colorfullantern/colorfullanternmainview.prefab"
	}
end

function ColorfulLanternMainViewPresentor:buildViews()
	return {
		ColorfulLanternMainView.New()
	}
end

return ColorfulLanternMainViewPresentor
