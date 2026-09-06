-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlematchViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlematchViewPresentor", package.seeall)

local LotusbattlematchViewPresentor = class("LotusbattlematchViewPresentor", ViewPresentor)

function LotusbattlematchViewPresentor:ctor()
	LotusbattlematchViewPresentor.super.ctor(self)
end

function LotusbattlematchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotusbattlematchViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlematchview.prefab"
	}
end

function LotusbattlematchViewPresentor:buildViews()
	return {
		LotusbattlematchView.New()
	}
end

return LotusbattlematchViewPresentor
