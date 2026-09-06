-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/PozhenTipsViewPresentor.lua

module("logic.extensions.breakformation.view.PozhenTipsViewPresentor", package.seeall)

local PozhenTipsViewPresentor = class("PozhenTipsViewPresentor", ViewPresentor)

function PozhenTipsViewPresentor:ctor()
	PozhenTipsViewPresentor.super.ctor(self)
end

function PozhenTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PozhenTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/breakformation/pozhentipsview.prefab"
	}
end

function PozhenTipsViewPresentor:buildViews()
	return {
		PozhenTipsView.New()
	}
end

return PozhenTipsViewPresentor
