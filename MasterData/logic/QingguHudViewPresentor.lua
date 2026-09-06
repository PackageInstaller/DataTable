-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qingguhud/view/QingguHudViewPresentor.lua

module("logic.extensions.qingguhud.view.QingguHudViewPresentor", package.seeall)

local QingguHudViewPresentor = class("QingguHudViewPresentor", ViewPresentor)

function QingguHudViewPresentor:ctor()
	QingguHudViewPresentor.super.ctor(self)
end

function QingguHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QingguHudViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/qingguhudview.prefab"
	}
end

function QingguHudViewPresentor:buildViews()
	return {
		QingguHudView.New()
	}
end

return QingguHudViewPresentor
