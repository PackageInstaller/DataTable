-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldStageBossResultViewPresentor.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldStageBossResultViewPresentor", package.seeall)

local HolyDragonFieldStageBossResultViewPresentor = class("HolyDragonFieldStageBossResultViewPresentor", ViewPresentor)

function HolyDragonFieldStageBossResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyDragonFieldStageBossResultViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragonfield/holydragonfieldstagebossresultview.prefab"
	}
end

function HolyDragonFieldStageBossResultViewPresentor:buildViews()
	return {
		HolyDragonFieldStageBossResultView.New()
	}
end

return HolyDragonFieldStageBossResultViewPresentor
