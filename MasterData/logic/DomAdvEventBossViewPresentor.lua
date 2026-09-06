-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventBossViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvEventBossViewPresentor", package.seeall)

local DomAdvEventBossViewPresentor = class("DomAdvEventBossViewPresentor", ViewPresentor)

function DomAdvEventBossViewPresentor:ctor()
	DomAdvEventBossViewPresentor.super.ctor(self)
end

function DomAdvEventBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvEventBossViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadveventbossview.prefab"
	}
end

function DomAdvEventBossViewPresentor:buildViews()
	return {
		DomAdvEventBossView.New()
	}
end

return DomAdvEventBossViewPresentor
