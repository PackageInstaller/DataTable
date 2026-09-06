-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/view/LinkagedocumentaryViewPresentor.lua

module("logic.extensions.linkageintroduction.view.LinkagedocumentaryViewPresentor", package.seeall)

local LinkagedocumentaryViewPresentor = class("LinkagedocumentaryViewPresentor", ViewPresentor)

function LinkagedocumentaryViewPresentor:ctor()
	LinkagedocumentaryViewPresentor.super.ctor(self)
end

function LinkagedocumentaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkagedocumentaryViewPresentor:dependWhatResources()
	return {
		"ui/views/linkageintroduction/linkagedocumentaryview.prefab"
	}
end

function LinkagedocumentaryViewPresentor:buildViews()
	return {
		LinkagedocumentaryView.New()
	}
end

return LinkagedocumentaryViewPresentor
