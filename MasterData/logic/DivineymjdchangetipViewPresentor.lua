-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/copy/DivineymjdchangetipViewPresentor.lua

module("logic.extensions.kingspacedragon.view.copy.DivineymjdchangetipViewPresentor", package.seeall)

local DivineymjdchangetipViewPresentor = class("DivineymjdchangetipViewPresentor", ViewPresentor)

function DivineymjdchangetipViewPresentor:ctor()
	DivineymjdchangetipViewPresentor.super.ctor(self)
end

function DivineymjdchangetipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineymjdchangetipViewPresentor:dependWhatResources()
	return {
		"ui/views/kingspacedragon/copy/divineymjdchangetipview.prefab"
	}
end

function DivineymjdchangetipViewPresentor:buildViews()
	return {
		DivineymjdchangetipView.New()
	}
end

return DivineymjdchangetipViewPresentor
