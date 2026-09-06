-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingwayprizeViewPresentor.lua

module("logic.extensions.kingway.view.KingwayprizeViewPresentor", package.seeall)

local KingwayprizeViewPresentor = class("KingwayprizeViewPresentor", ViewPresentor)

function KingwayprizeViewPresentor:ctor()
	KingwayprizeViewPresentor.super.ctor(self)
end

function KingwayprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingwayprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/kingway/kingwayprizeview.prefab"
	}
end

function KingwayprizeViewPresentor:buildViews()
	return {
		KingwayprizeView.New()
	}
end

return KingwayprizeViewPresentor
