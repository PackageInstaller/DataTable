-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampTaskViewPresentor.lua

module("logic.extensions.funcamp.view.FuncampTaskViewPresentor", package.seeall)

local FuncampTaskViewPresentor = class("FuncampTaskViewPresentor", ViewPresentor)

function FuncampTaskViewPresentor:ctor()
	FuncampTaskViewPresentor.super.ctor(self)
end

function FuncampTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuncampTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcamptaskview.prefab"
	}
end

function FuncampTaskViewPresentor:buildViews()
	return {
		FuncampTaskView.New()
	}
end

return FuncampTaskViewPresentor
