-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyscene/view/FamilySceneMainViewPresentor.lua

module("logic.extensions.familyscene.view.FamilySceneMainViewPresentor", package.seeall)

local FamilySceneMainViewPresentor = class("FamilySceneMainViewPresentor", ViewPresentor)

function FamilySceneMainViewPresentor:ctor()
	FamilySceneMainViewPresentor.super.ctor(self)
end

function FamilySceneMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilySceneMainViewPresentor:dependWhatResources()
	return {
		"ui/views/familyscene/view/familyscenemainview.prefab"
	}
end

function FamilySceneMainViewPresentor:buildViews()
	local views = {}

	table.insert(views, FamilySceneMainView.New())
	table.insert(views, MainChatView.New())

	return views
end

return FamilySceneMainViewPresentor
