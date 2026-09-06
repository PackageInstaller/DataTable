-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/view/HolyDragonTempleGoldFloorViewPresentor.lua

module("logic.extensions.holydragontemple.view.HolyDragonTempleGoldFloorViewPresentor", package.seeall)

local HolyDragonTempleGoldFloorViewPresentor = class("HolyDragonTempleGoldFloorViewPresentor", ViewPresentor)

function HolyDragonTempleGoldFloorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyDragonTempleGoldFloorViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragontemple/holydragontemplegoldfloorview.prefab"
	}
end

function HolyDragonTempleGoldFloorViewPresentor:buildViews()
	return {
		HolyDragonTempleGoldFloorView.New()
	}
end

function HolyDragonTempleGoldFloorViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyDragonTempleGoldFloorViewPresentor
