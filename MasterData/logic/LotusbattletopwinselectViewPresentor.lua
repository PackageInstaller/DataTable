-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattletopwinselectViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattletopwinselectViewPresentor", package.seeall)

local LotusbattletopwinselectViewPresentor = class("LotusbattletopwinselectViewPresentor", ViewPresentor)

function LotusbattletopwinselectViewPresentor:ctor()
	LotusbattletopwinselectViewPresentor.super.ctor(self)
end

function LotusbattletopwinselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotusbattletopwinselectViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattletopwinselectview.prefab"
	}
end

function LotusbattletopwinselectViewPresentor:buildViews()
	return {
		LotusbattletopwinselectView.New()
	}
end

return LotusbattletopwinselectViewPresentor
