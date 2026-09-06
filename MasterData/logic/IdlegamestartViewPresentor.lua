-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/IdlegamestartViewPresentor.lua

module("logic.extensions.idlegame.view.IdlegamestartViewPresentor", package.seeall)

local IdlegamestartViewPresentor = class("IdlegamestartViewPresentor", ViewPresentor)

function IdlegamestartViewPresentor:ctor()
	IdlegamestartViewPresentor.super.ctor(self)
end

function IdlegamestartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IdlegamestartViewPresentor:dependWhatResources()
	return {
		"ui/views/idlegame/idlegamestartview.prefab"
	}
end

function IdlegamestartViewPresentor:buildViews()
	return {
		IdlegamestartView.New()
	}
end

return IdlegamestartViewPresentor
