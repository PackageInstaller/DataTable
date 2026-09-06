-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglimainViewPresentor.lua

module("logic.extensions.mimengli.view.MimenglimainViewPresentor", package.seeall)

local MimenglimainViewPresentor = class("MimenglimainViewPresentor", ViewPresentor)

function MimenglimainViewPresentor:ctor()
	MimenglimainViewPresentor.super.ctor(self)
end

function MimenglimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MimenglimainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mimengli/mimenglimainview.prefab"
	}
end

function MimenglimainViewPresentor:buildViews()
	return {
		MimenglimainView.New()
	}
end

return MimenglimainViewPresentor
