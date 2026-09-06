-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattletaskViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattletaskViewPresentor", package.seeall)

local LotusbattletaskViewPresentor = class("LotusbattletaskViewPresentor", ViewPresentor)

function LotusbattletaskViewPresentor:ctor()
	LotusbattletaskViewPresentor.super.ctor(self)
end

function LotusbattletaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotusbattletaskViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattletaskview.prefab"
	}
end

function LotusbattletaskViewPresentor:buildViews()
	return {
		LotusbattletaskView.New()
	}
end

return LotusbattletaskViewPresentor
