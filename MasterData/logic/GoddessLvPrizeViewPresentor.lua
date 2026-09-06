-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddessLvPrizeViewPresentor.lua

module("logic.extensions.goddess.view.GoddessLvPrizeViewPresentor", package.seeall)

local GoddessLvPrizeViewPresentor = class("GoddessLvPrizeViewPresentor", ViewPresentor)

function GoddessLvPrizeViewPresentor:ctor()
	GoddessLvPrizeViewPresentor.super.ctor(self)
end

function GoddessLvPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessLvPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/goddess/goddesslvprizeview.prefab"
	}
end

function GoddessLvPrizeViewPresentor:buildViews()
	return {
		GoddessLvPrizeView.New()
	}
end

return GoddessLvPrizeViewPresentor
