-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlebuffViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlebuffViewPresentor", package.seeall)

local LotusbattlebuffViewPresentor = class("LotusbattlebuffViewPresentor", ViewPresentor)

function LotusbattlebuffViewPresentor:ctor()
	LotusbattlebuffViewPresentor.super.ctor(self)
end

function LotusbattlebuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotusbattlebuffViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlebuffview.prefab"
	}
end

function LotusbattlebuffViewPresentor:buildViews()
	return {
		LotusbattlebuffView.New()
	}
end

return LotusbattlebuffViewPresentor
