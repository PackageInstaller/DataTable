-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/testtab1/view/Testtab2Presentor.lua

module("logic.extensions.testtab1.view.Testtab2Presentor", package.seeall)

local Testtab2Presentor = class("Testtab2Presentor", ViewPresentor)

function Testtab2Presentor:ctor()
	Testtab2Presentor.super.ctor(self)
end

function Testtab2Presentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Testtab2Presentor:dependWhatResources()
	return {
		"ui/views/testtab1/testtab2view.prefab"
	}
end

function Testtab2Presentor:buildViews()
	return {
		Testtab2View.New()
	}
end

return Testtab2Presentor
