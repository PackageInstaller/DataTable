-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/IdlePrizeViewPresentor.lua

module("logic.extensions.idlegame.view.IdlePrizeViewPresentor", package.seeall)

local IdlePrizeViewPresentor = class("IdlePrizeViewPresentor", ViewPresentor)

function IdlePrizeViewPresentor:ctor()
	IdlePrizeViewPresentor.super.ctor(self)
end

function IdlePrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function IdlePrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/idlegame/idleprizeview.prefab"
	}
end

function IdlePrizeViewPresentor:buildViews()
	return {
		IdlePrizeView.New()
	}
end

return IdlePrizeViewPresentor
