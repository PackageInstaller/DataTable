-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingMainViewPresentor.lua

module("logic.extensions.chopking.view.ChopKingMainViewPresentor", package.seeall)

local ChopKingMainViewPresentor = class("ChopKingMainViewPresentor", ViewPresentor)

function ChopKingMainViewPresentor:ctor()
	ChopKingMainViewPresentor.super.ctor(self)
end

function ChopKingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChopKingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/chopking/chopkingmainview.prefab"
	}
end

function ChopKingMainViewPresentor:buildViews()
	return {
		ChopKingMainView.New()
	}
end

return ChopKingMainViewPresentor
