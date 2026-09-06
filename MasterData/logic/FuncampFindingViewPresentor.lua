-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampFindingViewPresentor.lua

module("logic.extensions.funcamp.view.FuncampFindingViewPresentor", package.seeall)

local FuncampFindingViewPresentor = class("FuncampFindingViewPresentor", ViewPresentor)

function FuncampFindingViewPresentor:ctor()
	FuncampFindingViewPresentor.super.ctor(self)
end

function FuncampFindingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuncampFindingViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcampfindingview.prefab"
	}
end

function FuncampFindingViewPresentor:buildViews()
	return {
		FuncampFindingView.New()
	}
end

return FuncampFindingViewPresentor
