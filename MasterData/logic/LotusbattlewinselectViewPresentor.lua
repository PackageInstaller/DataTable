-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlewinselectViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlewinselectViewPresentor", package.seeall)

local LotusbattlewinselectViewPresentor = class("LotusbattlewinselectViewPresentor", ViewPresentor)

function LotusbattlewinselectViewPresentor:ctor()
	LotusbattlewinselectViewPresentor.super.ctor(self)
end

function LotusbattlewinselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotusbattlewinselectViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlewinselectview.prefab"
	}
end

function LotusbattlewinselectViewPresentor:buildViews()
	return {
		LotusbattlewinselectView.New()
	}
end

return LotusbattlewinselectViewPresentor
