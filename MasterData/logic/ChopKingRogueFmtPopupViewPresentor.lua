-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingRogueFmtPopupViewPresentor.lua

module("logic.extensions.chopking.view.ChopKingRogueFmtPopupViewPresentor", package.seeall)

local ChopKingRogueFmtPopupViewPresentor = class("ChopKingRogueFmtPopupViewPresentor", ViewPresentor)

function ChopKingRogueFmtPopupViewPresentor:ctor()
	ChopKingRogueFmtPopupViewPresentor.super.ctor(self)
end

function ChopKingRogueFmtPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChopKingRogueFmtPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/chopking/chopkingroguefmtpopupview.prefab"
	}
end

function ChopKingRogueFmtPopupViewPresentor:buildViews()
	return {
		ChopKingRogueFmtPopupView.New()
	}
end

return ChopKingRogueFmtPopupViewPresentor
