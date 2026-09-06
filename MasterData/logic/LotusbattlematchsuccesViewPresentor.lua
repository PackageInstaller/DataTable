-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlematchsuccesViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlematchsuccesViewPresentor", package.seeall)

local LotusbattlematchsuccesViewPresentor = class("LotusbattlematchsuccesViewPresentor", ViewPresentor)

function LotusbattlematchsuccesViewPresentor:ctor()
	LotusbattlematchsuccesViewPresentor.super.ctor(self)
end

function LotusbattlematchsuccesViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotusbattlematchsuccesViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlematchsuccesview.prefab"
	}
end

function LotusbattlematchsuccesViewPresentor:buildViews()
	return {
		LotusbattlematchsuccesView.New()
	}
end

return LotusbattlematchsuccesViewPresentor
