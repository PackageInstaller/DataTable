-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/DivineelizabethmainViewPresentor.lua

module("logic.extensions.ashechallenge.view.DivineelizabethmainViewPresentor", package.seeall)

local DivineelizabethmainViewPresentor = class("DivineelizabethmainViewPresentor", ViewPresentor)

function DivineelizabethmainViewPresentor:ctor()
	DivineelizabethmainViewPresentor.super.ctor(self)
end

function DivineelizabethmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineelizabethmainViewPresentor:dependWhatResources()
	return {
		"ui/views/ashechallenge/divineelizabethmainview.prefab"
	}
end

function DivineelizabethmainViewPresentor:buildViews()
	return {
		DivineelizabethmainView.New()
	}
end

return DivineelizabethmainViewPresentor
