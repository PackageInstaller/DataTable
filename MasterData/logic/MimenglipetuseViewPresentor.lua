-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglipetuseViewPresentor.lua

module("logic.extensions.mimengli.view.MimenglipetuseViewPresentor", package.seeall)

local MimenglipetuseViewPresentor = class("MimenglipetuseViewPresentor", ViewPresentor)

function MimenglipetuseViewPresentor:ctor()
	MimenglipetuseViewPresentor.super.ctor(self)
end

function MimenglipetuseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MimenglipetuseViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mimengli/mimenglipetuseview.prefab"
	}
end

function MimenglipetuseViewPresentor:buildViews()
	return {
		MimenglipetuseView.New()
	}
end

return MimenglipetuseViewPresentor
