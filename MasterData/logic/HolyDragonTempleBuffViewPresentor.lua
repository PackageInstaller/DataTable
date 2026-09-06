-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/view/HolyDragonTempleBuffViewPresentor.lua

module("logic.extensions.holydragontemple.view.HolyDragonTempleBuffViewPresentor", package.seeall)

local HolyDragonTempleBuffViewPresentor = class("HolyDragonTempleBuffViewPresentor", ViewPresentor)

function HolyDragonTempleBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyDragonTempleBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragontemple/holydragontemplebuffview.prefab"
	}
end

function HolyDragonTempleBuffViewPresentor:buildViews()
	return {
		HolyDragonTempleBuffView.New()
	}
end

return HolyDragonTempleBuffViewPresentor
