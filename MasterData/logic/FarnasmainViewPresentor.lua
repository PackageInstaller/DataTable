-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasmainViewPresentor.lua

module("logic.extensions.farnas.view.FarnasmainViewPresentor", package.seeall)

local FarnasmainViewPresentor = class("FarnasmainViewPresentor", ViewPresentor)

function FarnasmainViewPresentor:ctor()
	FarnasmainViewPresentor.super.ctor(self)
end

function FarnasmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FarnasmainViewPresentor:dependWhatResources()
	return {
		"ui/views/farnas/farnasmainview.prefab"
	}
end

function FarnasmainViewPresentor:buildViews()
	return {
		FarnasmainView.New()
	}
end

return FarnasmainViewPresentor
