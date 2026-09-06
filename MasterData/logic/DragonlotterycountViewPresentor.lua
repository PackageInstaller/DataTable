-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DragonlotterycountViewPresentor.lua

module("logic.extensions.lottery.view.DragonlotterycountViewPresentor", package.seeall)

local DragonlotterycountViewPresentor = class("DragonlotterycountViewPresentor", ViewPresentor)

function DragonlotterycountViewPresentor:ctor()
	DragonlotterycountViewPresentor.super.ctor(self)
end

function DragonlotterycountViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DragonlotterycountViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/dragonlotterycountview.prefab"
	}
end

function DragonlotterycountViewPresentor:buildViews()
	return {
		DragonlotterycountView.New()
	}
end

return DragonlotterycountViewPresentor
