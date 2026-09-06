-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampCompeteViewPresentor.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampCompeteViewPresentor", package.seeall)

local FunCampCompeteViewPresentor = class("FunCampCompeteViewPresentor", ViewPresentor)

function FunCampCompeteViewPresentor:ctor()
	FunCampCompeteViewPresentor.super.ctor(self)
end

function FunCampCompeteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunCampCompeteViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcampcompeteview.prefab"
	}
end

function FunCampCompeteViewPresentor:buildViews()
	return {
		FunCampCompeteView.New()
	}
end

return FunCampCompeteViewPresentor
