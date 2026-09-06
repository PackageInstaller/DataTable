-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinaljumpViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinaljumpViewPresentor", package.seeall)

local MartialcontestfinaljumpViewPresentor = class("MartialcontestfinaljumpViewPresentor", ViewPresentor)

function MartialcontestfinaljumpViewPresentor:ctor()
	MartialcontestfinaljumpViewPresentor.super.ctor(self)
end

function MartialcontestfinaljumpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinaljumpViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinaljumpview.prefab"
	}
end

function MartialcontestfinaljumpViewPresentor:buildViews()
	return {
		MartialcontestfinaljumpView.New()
	}
end

return MartialcontestfinaljumpViewPresentor
