-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/view/ElizabethpopuptipsViewPresentor.lua

module("logic.extensions.elizabethgame.view.ElizabethpopuptipsViewPresentor", package.seeall)

local ElizabethpopuptipsViewPresentor = class("ElizabethpopuptipsViewPresentor", ViewPresentor)

function ElizabethpopuptipsViewPresentor:ctor()
	ElizabethpopuptipsViewPresentor.super.ctor(self)
end

function ElizabethpopuptipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ElizabethpopuptipsViewPresentor:dependWhatResources()
	return {
		"ui/views/elizabethgame/elizabethpopuptipsview.prefab"
	}
end

function ElizabethpopuptipsViewPresentor:buildViews()
	return {
		ElizabethpopuptipsView.New()
	}
end

return ElizabethpopuptipsViewPresentor
