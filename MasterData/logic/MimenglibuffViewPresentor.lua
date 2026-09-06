-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglibuffViewPresentor.lua

module("logic.extensions.mimengli.view.MimenglibuffViewPresentor", package.seeall)

local MimenglibuffViewPresentor = class("MimenglibuffViewPresentor", ViewPresentor)

function MimenglibuffViewPresentor:ctor()
	MimenglibuffViewPresentor.super.ctor(self)
end

function MimenglibuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MimenglibuffViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mimengli/mimenglibuffview.prefab"
	}
end

function MimenglibuffViewPresentor:buildViews()
	return {
		MimenglibuffView.New()
	}
end

return MimenglibuffViewPresentor
