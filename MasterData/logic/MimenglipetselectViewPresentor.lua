-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglipetselectViewPresentor.lua

module("logic.extensions.mimengli.view.MimenglipetselectViewPresentor", package.seeall)

local MimenglipetselectViewPresentor = class("MimenglipetselectViewPresentor", ViewPresentor)

function MimenglipetselectViewPresentor:ctor()
	MimenglipetselectViewPresentor.super.ctor(self)
end

function MimenglipetselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MimenglipetselectViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mimengli/mimenglipetselectview.prefab"
	}
end

function MimenglipetselectViewPresentor:buildViews()
	return {
		MimenglipetselectView.New()
	}
end

return MimenglipetselectViewPresentor
