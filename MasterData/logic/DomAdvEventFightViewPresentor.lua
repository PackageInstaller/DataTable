-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventFightViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvEventFightViewPresentor", package.seeall)

local DomAdvEventFightViewPresentor = class("DomAdvEventFightViewPresentor", ViewPresentor)

function DomAdvEventFightViewPresentor:ctor()
	DomAdvEventFightViewPresentor.super.ctor(self)
end

function DomAdvEventFightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvEventFightViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadveventfightview.prefab"
	}
end

function DomAdvEventFightViewPresentor:buildViews()
	return {
		DomAdvEventFightView.New()
	}
end

return DomAdvEventFightViewPresentor
