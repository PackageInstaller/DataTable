-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglibuffchangeViewPresentor.lua

module("logic.extensions.mimengli.view.MimenglibuffchangeViewPresentor", package.seeall)

local MimenglibuffchangeViewPresentor = class("MimenglibuffchangeViewPresentor", ViewPresentor)

function MimenglibuffchangeViewPresentor:ctor()
	MimenglibuffchangeViewPresentor.super.ctor(self)
end

function MimenglibuffchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MimenglibuffchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mimengli/mimenglibuffchangeview.prefab"
	}
end

function MimenglibuffchangeViewPresentor:buildViews()
	return {
		MimenglibuffchangeView.New()
	}
end

return MimenglibuffchangeViewPresentor
