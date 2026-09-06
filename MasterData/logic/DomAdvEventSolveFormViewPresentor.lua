-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventSolveFormViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvEventSolveFormViewPresentor", package.seeall)

local DomAdvEventSolveFormViewPresentor = class("DomAdvEventSolveFormViewPresentor", ViewPresentor)

function DomAdvEventSolveFormViewPresentor:ctor()
	DomAdvEventSolveFormViewPresentor.super.ctor(self)
end

function DomAdvEventSolveFormViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvEventSolveFormViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadveventsolveformview.prefab"
	}
end

function DomAdvEventSolveFormViewPresentor:buildViews()
	return {
		DomAdvEventSolveFormView.New()
	}
end

return DomAdvEventSolveFormViewPresentor
