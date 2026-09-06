-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/KingspacedragonchangetipViewPresentor.lua

module("logic.extensions.kingspacedragon.view.KingspacedragonchangetipViewPresentor", package.seeall)

local KingspacedragonchangetipViewPresentor = class("KingspacedragonchangetipViewPresentor", ViewPresentor)

function KingspacedragonchangetipViewPresentor:ctor()
	KingspacedragonchangetipViewPresentor.super.ctor(self)
end

function KingspacedragonchangetipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingspacedragonchangetipViewPresentor:dependWhatResources()
	return {
		"ui/views/kingspacedragon/kingspacedragonchangetipview.prefab"
	}
end

function KingspacedragonchangetipViewPresentor:buildViews()
	return {
		KingspacedragonchangetipView.New()
	}
end

return KingspacedragonchangetipViewPresentor
