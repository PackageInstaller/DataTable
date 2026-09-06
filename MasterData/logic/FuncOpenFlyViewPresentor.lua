-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/view/FuncOpenFlyViewPresentor.lua

module("logic.extensions.funcopen.view.FuncOpenFlyViewPresentor", package.seeall)

local FuncOpenFlyViewPresentor = class("FuncOpenFlyViewPresentor", ViewPresentor)

function FuncOpenFlyViewPresentor:ctor()
	FuncOpenFlyViewPresentor.super.ctor(self)
end

function FuncOpenFlyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuncOpenFlyViewPresentor:dependWhatResources()
	return {
		"ui/views/funcopen/funcopenflyview.prefab"
	}
end

function FuncOpenFlyViewPresentor:buildViews()
	return {
		FuncOpenFlyView.New()
	}
end

return FuncOpenFlyViewPresentor
