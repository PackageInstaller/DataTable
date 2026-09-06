-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampSelectViewPresentor.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampSelectViewPresentor", package.seeall)

local FunCampSelectViewPresentor = class("FunCampSelectViewPresentor", ViewPresentor)

function FunCampSelectViewPresentor:ctor()
	FunCampSelectViewPresentor.super.ctor(self)
end

function FunCampSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunCampSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcampselectview.prefab"
	}
end

function FunCampSelectViewPresentor:buildViews()
	return {
		FunCampSelectView.New()
	}
end

return FunCampSelectViewPresentor
