-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/view/HolyDragonTemplePassPopWinPresentor.lua

module("logic.extensions.holydragontemple.view.HolyDragonTemplePassPopWinPresentor", package.seeall)

local HolyDragonTemplePassPopWinPresentor = class("HolyDragonTemplePassPopWinPresentor", ViewPresentor)

function HolyDragonTemplePassPopWinPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyDragonTemplePassPopWinPresentor:dependWhatResources()
	return {
		"ui/views/holydragontemple/holydragontemplepasspopwin.prefab"
	}
end

function HolyDragonTemplePassPopWinPresentor:buildViews()
	return {
		HolyDragonTemplePassPopWin.New()
	}
end

return HolyDragonTemplePassPopWinPresentor
