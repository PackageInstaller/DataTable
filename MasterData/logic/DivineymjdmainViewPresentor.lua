-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/copy/DivineymjdmainViewPresentor.lua

module("logic.extensions.kingspacedragon.view.copy.DivineymjdmainViewPresentor", package.seeall)

local DivineymjdmainViewPresentor = class("DivineymjdmainViewPresentor", ViewPresentor)

function DivineymjdmainViewPresentor:ctor()
	DivineymjdmainViewPresentor.super.ctor(self)
end

function DivineymjdmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineymjdmainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingspacedragon/copy/divineymjdmainview.prefab"
	}
end

function DivineymjdmainViewPresentor:buildViews()
	return {
		DivineymjdmainView.New()
	}
end

return DivineymjdmainViewPresentor
