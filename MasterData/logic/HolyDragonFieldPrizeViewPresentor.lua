-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldPrizeViewPresentor.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldPrizeViewPresentor", package.seeall)

local HolyDragonFieldPrizeViewPresentor = class("HolyDragonFieldPrizeViewPresentor", ViewPresentor)

function HolyDragonFieldPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyDragonFieldPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragonfield/holydragonfieldprizeview.prefab"
	}
end

function HolyDragonFieldPrizeViewPresentor:buildViews()
	return {
		HolyDragonFieldPrizeView.New()
	}
end

return HolyDragonFieldPrizeViewPresentor
