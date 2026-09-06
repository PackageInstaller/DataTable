-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/copy/DivineymjdlevelsViewPresentor.lua

module("logic.extensions.kingspacedragon.view.copy.DivineymjdlevelsViewPresentor", package.seeall)

local DivineymjdlevelsViewPresentor = class("DivineymjdlevelsViewPresentor", ViewPresentor)

function DivineymjdlevelsViewPresentor:ctor()
	DivineymjdlevelsViewPresentor.super.ctor(self)
end

function DivineymjdlevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineymjdlevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/kingspacedragon/copy/divineymjdlevelsview.prefab"
	}
end

function DivineymjdlevelsViewPresentor:buildViews()
	return {
		DivineymjdlevelsView.New()
	}
end

return DivineymjdlevelsViewPresentor
