-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/view/HolyDragonTempleMainViewPresentor.lua

module("logic.extensions.holydragontemple.view.HolyDragonTempleMainViewPresentor", package.seeall)

local HolyDragonTempleMainViewPresentor = class("HolyDragonTempleMainViewPresentor", ViewPresentor)

function HolyDragonTempleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyDragonTempleMainViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragontemple/holydragontemplemainview.prefab"
	}
end

function HolyDragonTempleMainViewPresentor:buildViews()
	return {
		HolyDragonTempleMainView.New()
	}
end

return HolyDragonTempleMainViewPresentor
