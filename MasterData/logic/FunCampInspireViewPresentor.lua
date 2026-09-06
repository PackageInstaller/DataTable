-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampInspireViewPresentor.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampInspireViewPresentor", package.seeall)

local FunCampInspireViewPresentor = class("FunCampInspireViewPresentor", ViewPresentor)

function FunCampInspireViewPresentor:ctor()
	FunCampInspireViewPresentor.super.ctor(self)
end

function FunCampInspireViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunCampInspireViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcampinspireview.prefab"
	}
end

function FunCampInspireViewPresentor:buildViews()
	return {
		FunCampInspireView.New()
	}
end

return FunCampInspireViewPresentor
