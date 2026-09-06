-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutepetassistanceselectViewPresentor.lua

module("logic.extensions.cutepet.view.CutepetassistanceselectViewPresentor", package.seeall)

local CutepetassistanceselectViewPresentor = class("CutepetassistanceselectViewPresentor", ViewPresentor)

function CutepetassistanceselectViewPresentor:ctor()
	CutepetassistanceselectViewPresentor.super.ctor(self)
end

function CutepetassistanceselectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CutepetassistanceselectViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetassistanceselectview.prefab"
	}
end

function CutepetassistanceselectViewPresentor:buildViews()
	return {
		CutepetassistanceselectView.New()
	}
end

return CutepetassistanceselectViewPresentor
