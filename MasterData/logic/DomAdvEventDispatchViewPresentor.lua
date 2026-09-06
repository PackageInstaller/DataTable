-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventDispatchViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvEventDispatchViewPresentor", package.seeall)

local DomAdvEventDispatchViewPresentor = class("DomAdvEventDispatchViewPresentor", ViewPresentor)

function DomAdvEventDispatchViewPresentor:ctor()
	DomAdvEventDispatchViewPresentor.super.ctor(self)
end

function DomAdvEventDispatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvEventDispatchViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadveventdispatchview.prefab"
	}
end

function DomAdvEventDispatchViewPresentor:buildViews()
	return {
		DomAdvEventDispatchView.New()
	}
end

return DomAdvEventDispatchViewPresentor
