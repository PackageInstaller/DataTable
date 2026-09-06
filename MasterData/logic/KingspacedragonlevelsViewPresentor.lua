-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/KingspacedragonlevelsViewPresentor.lua

module("logic.extensions.kingspacedragon.view.KingspacedragonlevelsViewPresentor", package.seeall)

local KingspacedragonlevelsViewPresentor = class("KingspacedragonlevelsViewPresentor", ViewPresentor)

function KingspacedragonlevelsViewPresentor:ctor()
	KingspacedragonlevelsViewPresentor.super.ctor(self)
end

function KingspacedragonlevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingspacedragonlevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/kingspacedragon/kingspacedragonlevelsview.prefab"
	}
end

function KingspacedragonlevelsViewPresentor:buildViews()
	return {
		KingspacedragonlevelsView.New()
	}
end

return KingspacedragonlevelsViewPresentor
