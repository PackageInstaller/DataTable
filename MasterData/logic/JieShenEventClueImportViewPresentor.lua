-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventClueImportViewPresentor.lua

module("logic.extensions.jieshenevent.view.JieShenEventClueImportViewPresentor", package.seeall)

local JieShenEventClueImportViewPresentor = class("JieShenEventClueImportViewPresentor", ViewPresentor)

function JieShenEventClueImportViewPresentor:ctor()
	JieShenEventClueImportViewPresentor.super.ctor(self)
end

function JieShenEventClueImportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JieShenEventClueImportViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenevent/jiesheneventcluetipsview.prefab"
	}
end

function JieShenEventClueImportViewPresentor:buildViews()
	return {
		JieShenEventClueImportView.New()
	}
end

return JieShenEventClueImportViewPresentor
