-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonBudgetPopViewPresentor.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonBudgetPopViewPresentor", package.seeall)

local OriginAshlessDragonBudgetPopViewPresentor = class("OriginAshlessDragonBudgetPopViewPresentor", ViewPresentor)

function OriginAshlessDragonBudgetPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginAshlessDragonBudgetPopViewPresentor:dependWhatResources()
	return {
		"ui/views/originashlessdragon/originashlessdragonbudgetpopview.prefab"
	}
end

function OriginAshlessDragonBudgetPopViewPresentor:buildViews()
	return {
		OriginAshlessDragonBudgetPopView.New()
	}
end

return OriginAshlessDragonBudgetPopViewPresentor
