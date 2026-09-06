-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/copy/DivineymjdpopViewPresentor.lua

module("logic.extensions.kingspacedragon.view.copy.DivineymjdpopViewPresentor", package.seeall)

local DivineymjdpopViewPresentor = class("DivineymjdpopViewPresentor", ViewPresentor)

function DivineymjdpopViewPresentor:ctor()
	DivineymjdpopViewPresentor.super.ctor(self)
end

function DivineymjdpopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineymjdpopViewPresentor:dependWhatResources()
	return {
		"ui/views/kingspacedragon/copy/divineymjdpopview.prefab"
	}
end

function DivineymjdpopViewPresentor:buildViews()
	return {
		DivineymjdpopView.New()
	}
end

return DivineymjdpopViewPresentor
