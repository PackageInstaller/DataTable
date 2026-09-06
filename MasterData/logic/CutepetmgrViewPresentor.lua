-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutepetmgrViewPresentor.lua

module("logic.extensions.cutepet.view.CutepetmgrViewPresentor", package.seeall)

local CutepetmgrViewPresentor = class("CutepetmgrViewPresentor", ViewPresentor)

function CutepetmgrViewPresentor:ctor()
	CutepetmgrViewPresentor.super.ctor(self)
end

function CutepetmgrViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CutepetmgrViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetmgrview.prefab"
	}
end

function CutepetmgrViewPresentor:buildViews()
	return {
		CutepetmgrView.New()
	}
end

return CutepetmgrViewPresentor
