-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattleprepareViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattleprepareViewPresentor", package.seeall)

local LotusbattleprepareViewPresentor = class("LotusbattleprepareViewPresentor", ViewPresentor)

function LotusbattleprepareViewPresentor:ctor()
	LotusbattleprepareViewPresentor.super.ctor(self)
end

function LotusbattleprepareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotusbattleprepareViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattleprepareview.prefab"
	}
end

function LotusbattleprepareViewPresentor:buildViews()
	return {
		LotusbattleprepareView.New()
	}
end

return LotusbattleprepareViewPresentor
