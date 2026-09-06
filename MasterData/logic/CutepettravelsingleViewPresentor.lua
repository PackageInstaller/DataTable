-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutepettravelsingleViewPresentor.lua

module("logic.extensions.cutepet.view.CutepettravelsingleViewPresentor", package.seeall)

local CutepettravelsingleViewPresentor = class("CutepettravelsingleViewPresentor", ViewPresentor)

function CutepettravelsingleViewPresentor:ctor()
	CutepettravelsingleViewPresentor.super.ctor(self)
end

function CutepettravelsingleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutepettravelsingleViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepettravelsingleview.prefab"
	}
end

function CutepettravelsingleViewPresentor:buildViews()
	return {
		CutepettravelsingleView.New()
	}
end

return CutepettravelsingleViewPresentor
