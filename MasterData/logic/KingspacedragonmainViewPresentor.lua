-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/KingspacedragonmainViewPresentor.lua

module("logic.extensions.kingspacedragon.view.KingspacedragonmainViewPresentor", package.seeall)

local KingspacedragonmainViewPresentor = class("KingspacedragonmainViewPresentor", ViewPresentor)

function KingspacedragonmainViewPresentor:ctor()
	KingspacedragonmainViewPresentor.super.ctor(self)
end

function KingspacedragonmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingspacedragonmainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingspacedragon/kingspacedragonmainview.prefab"
	}
end

function KingspacedragonmainViewPresentor:buildViews()
	return {
		KingspacedragonmainView.New()
	}
end

return KingspacedragonmainViewPresentor
