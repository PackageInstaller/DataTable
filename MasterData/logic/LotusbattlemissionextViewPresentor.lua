-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlemissionextViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlemissionextViewPresentor", package.seeall)

local LotusbattlemissionextViewPresentor = class("LotusbattlemissionextViewPresentor", ViewPresentor)

function LotusbattlemissionextViewPresentor:ctor()
	LotusbattlemissionextViewPresentor.super.ctor(self)
end

function LotusbattlemissionextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotusbattlemissionextViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlemissionextview.prefab"
	}
end

function LotusbattlemissionextViewPresentor:buildViews()
	return {
		LotusbattlemissionextView.New()
	}
end

return LotusbattlemissionextViewPresentor
