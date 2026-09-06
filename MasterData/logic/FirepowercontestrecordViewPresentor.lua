-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirepowercontestrecordViewPresentor.lua

module("logic.extensions.firepowercontest.view.FirepowercontestrecordViewPresentor", package.seeall)

local FirepowercontestrecordViewPresentor = class("FirepowercontestrecordViewPresentor", ViewPresentor)

function FirepowercontestrecordViewPresentor:ctor()
	FirepowercontestrecordViewPresentor.super.ctor(self)
end

function FirepowercontestrecordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FirepowercontestrecordViewPresentor:dependWhatResources()
	return {
		"ui/views/firepowercontest/firepowercontestrecordview.prefab"
	}
end

function FirepowercontestrecordViewPresentor:buildViews()
	return {
		FirePowerContestRecordView.New()
	}
end

return FirepowercontestrecordViewPresentor
