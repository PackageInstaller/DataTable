-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroPrizeViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroPrizeViewPresentor", package.seeall)

local MiracleHeroPrizeViewPresentor = class("MiracleHeroPrizeViewPresentor", ViewPresentor)

function MiracleHeroPrizeViewPresentor:ctor()
	MiracleHeroPrizeViewPresentor.super.ctor(self)
end

function MiracleHeroPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiracleHeroPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleheroprizeview.prefab"
	}
end

function MiracleHeroPrizeViewPresentor:buildViews()
	return {
		MiracleHeroPrizeView.New()
	}
end

return MiracleHeroPrizeViewPresentor
