-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventEliteFightViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvEventEliteFightViewPresentor", package.seeall)

local DomAdvEventEliteFightViewPresentor = class("DomAdvEventEliteFightViewPresentor", ViewPresentor)

function DomAdvEventEliteFightViewPresentor:ctor()
	DomAdvEventEliteFightViewPresentor.super.ctor(self)
end

function DomAdvEventEliteFightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvEventEliteFightViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadveventelitefightview.prefab"
	}
end

function DomAdvEventEliteFightViewPresentor:buildViews()
	return {
		DomAdvEventEliteFightView.New()
	}
end

return DomAdvEventEliteFightViewPresentor
