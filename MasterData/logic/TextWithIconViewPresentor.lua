-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/TextWithIconViewPresentor.lua

module("logic.extensions.tips.view.TextWithIconViewPresentor", package.seeall)

local TextWithIconViewPresentor = class("TextWithIconViewPresentor", ViewPresentor)

function TextWithIconViewPresentor:ctor()
	TextWithIconViewPresentor.super.ctor(self)
end

function TextWithIconViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TextWithIconViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/textwithiconview.prefab"
	}
end

function TextWithIconViewPresentor:buildViews()
	return {
		TextWithIconView.New()
	}
end

return TextWithIconViewPresentor
