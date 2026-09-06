-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/testtab1/view/Testtab1Presentor.lua

module("logic.extensions.testtab1.view.Testtab1Presentor", package.seeall)

local Testtab1Presentor = class("Testtab1Presentor", ViewPresentor)

function Testtab1Presentor:ctor()
	Testtab1Presentor.super.ctor(self)
end

function Testtab1Presentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Testtab1Presentor:dependWhatResources()
	return {
		"ui/views/testtab1/testtab1view.prefab"
	}
end

function Testtab1Presentor:buildViews()
	return {
		Testtab1View.New()
	}
end

function Testtab1Presentor:toString()
	print("this is Testtab1Presentor")
end

return Testtab1Presentor
