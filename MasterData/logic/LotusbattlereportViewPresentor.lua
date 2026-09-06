-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlereportViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlereportViewPresentor", package.seeall)

local LotusbattlereportViewPresentor = class("LotusbattlereportViewPresentor", ViewPresentor)

function LotusbattlereportViewPresentor:ctor()
	LotusbattlereportViewPresentor.super.ctor(self)
end

function LotusbattlereportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotusbattlereportViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlereportview.prefab"
	}
end

function LotusbattlereportViewPresentor:buildViews()
	return {
		LotusbattlereportView.New()
	}
end

return LotusbattlereportViewPresentor
