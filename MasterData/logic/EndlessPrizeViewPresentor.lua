-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/view/EndlessPrizeViewPresentor.lua

module("logic.extensions.endlessbattle.view.EndlessPrizeViewPresentor", package.seeall)

local EndlessPrizeViewPresentor = class("EndlessPrizeViewPresentor", ViewPresentor)

function EndlessPrizeViewPresentor:ctor()
	EndlessPrizeViewPresentor.super.ctor(self)
end

function EndlessPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EndlessPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/endlessbattle/endlessprizeview.prefab"
	}
end

function EndlessPrizeViewPresentor:buildViews()
	return {
		EndlessPrizeView.New()
	}
end

return EndlessPrizeViewPresentor
