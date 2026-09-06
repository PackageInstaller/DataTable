-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/elizabeth/ElizabethMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.elizabeth.ElizabethMainViewPresentor", package.seeall)

local ElizabethMainViewPresentor = class("ElizabethMainViewPresentor", ViewPresentor)

function ElizabethMainViewPresentor:ctor()
	ElizabethMainViewPresentor.super.ctor(self)
end

function ElizabethMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElizabethMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/elizabeth/elizabethmainview.prefab"
	}
end

function ElizabethMainViewPresentor:buildViews()
	return {
		ElizabethMainView.New()
	}
end

function ElizabethMainViewPresentor:getTempResources()
	return {
		"lihui_spine/10322_yilishabai_lihui/10322_yilishabai_lihui-ui_p.prefab"
	}
end

return ElizabethMainViewPresentor
