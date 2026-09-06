-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomainAdventureMainHudViewPresentor.lua

module("logic.extensions.domainadventure.view.DomainAdventureMainHudViewPresentor", package.seeall)

local DomainAdventureMainHudViewPresentor = class("DomainAdventureMainHudViewPresentor", ViewPresentor)

function DomainAdventureMainHudViewPresentor:ctor()
	DomainAdventureMainHudViewPresentor.super.ctor(self)
end

function DomainAdventureMainHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomainAdventureMainHudViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domainadventuremainhudview.prefab"
	}
end

function DomainAdventureMainHudViewPresentor:buildViews()
	return {
		DomainAdventureMainHudView.New()
	}
end

function DomainAdventureMainHudViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DomainAdventureMainHudViewPresentor
