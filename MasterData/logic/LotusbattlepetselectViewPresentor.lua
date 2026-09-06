-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlepetselectViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlepetselectViewPresentor", package.seeall)

local LotusbattlepetselectViewPresentor = class("LotusbattlepetselectViewPresentor", ViewPresentor)

function LotusbattlepetselectViewPresentor:ctor()
	LotusbattlepetselectViewPresentor.super.ctor(self)
end

function LotusbattlepetselectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotusbattlepetselectViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlepetselectview.prefab"
	}
end

function LotusbattlepetselectViewPresentor:buildViews()
	return {
		LotusbattlepetselectView.New()
	}
end

return LotusbattlepetselectViewPresentor
