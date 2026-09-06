-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlemainViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlemainViewPresentor", package.seeall)

local LotusbattlemainViewPresentor = class("LotusbattlemainViewPresentor", ViewPresentor)

function LotusbattlemainViewPresentor:ctor()
	LotusbattlemainViewPresentor.super.ctor(self)
end

function LotusbattlemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotusbattlemainViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlemainview.prefab"
	}
end

function LotusbattlemainViewPresentor:buildViews()
	return {
		LotusbattlemainView.New()
	}
end

return LotusbattlemainViewPresentor
