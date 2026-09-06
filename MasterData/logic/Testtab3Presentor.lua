-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/testtab1/view/Testtab3Presentor.lua

module("logic.extensions.testtab1.view.Testtab3Presentor", package.seeall)

local Testtab3Presentor = class("Testtab3Presentor", ViewPresentor)

function Testtab3Presentor:ctor()
	Testtab3Presentor.super.ctor(self)
end

function Testtab3Presentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Testtab3Presentor:dependWhatResources()
	return {
		"ui/views/testtab1/testtab3view.prefab"
	}
end

function Testtab3Presentor:buildViews()
	return {
		Testtab3View.New()
	}
end

return Testtab3Presentor
