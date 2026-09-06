-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/KingspacedragonpopViewPresentor.lua

module("logic.extensions.kingspacedragon.view.KingspacedragonpopViewPresentor", package.seeall)

local KingspacedragonpopViewPresentor = class("KingspacedragonpopViewPresentor", ViewPresentor)

function KingspacedragonpopViewPresentor:ctor()
	KingspacedragonpopViewPresentor.super.ctor(self)
end

function KingspacedragonpopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingspacedragonpopViewPresentor:dependWhatResources()
	return {
		"ui/views/kingspacedragon/kingspacedragonpopview.prefab"
	}
end

function KingspacedragonpopViewPresentor:buildViews()
	return {
		KingspacedragonpopView.New()
	}
end

return KingspacedragonpopViewPresentor
