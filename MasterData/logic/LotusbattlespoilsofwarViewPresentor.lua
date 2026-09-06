-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlespoilsofwarViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlespoilsofwarViewPresentor", package.seeall)

local LotusbattlespoilsofwarViewPresentor = class("LotusbattlespoilsofwarViewPresentor", ViewPresentor)

function LotusbattlespoilsofwarViewPresentor:ctor()
	LotusbattlespoilsofwarViewPresentor.super.ctor(self)
end

function LotusbattlespoilsofwarViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotusbattlespoilsofwarViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlespoilsofwarview.prefab"
	}
end

function LotusbattlespoilsofwarViewPresentor:buildViews()
	return {
		LotusbattlespoilsofwarView.New()
	}
end

return LotusbattlespoilsofwarViewPresentor
