-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/view/ColorfulLanternIntroViewPresentor.lua

module("logic.extensions.colorfullantern.view.ColorfulLanternIntroViewPresentor", package.seeall)

local ColorfulLanternIntroViewPresentor = class("ColorfulLanternIntroViewPresentor", ViewWithGuidePresentor)

function ColorfulLanternIntroViewPresentor:ctor()
	ColorfulLanternIntroViewPresentor.super.ctor(self)
end

function ColorfulLanternIntroViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ColorfulLanternIntroViewPresentor:dependWhatResources()
	return {
		"ui/views/colorfullantern/colorfullanternintroview.prefab"
	}
end

function ColorfulLanternIntroViewPresentor:buildViews()
	return {
		ColorfulLanternIntroView.New()
	}
end

return ColorfulLanternIntroViewPresentor
