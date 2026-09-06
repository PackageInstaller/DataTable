-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupGroupInfoViewPresentor.lua

module("logic.extensions.worldcup.view.WorldCupGroupInfoViewPresentor", package.seeall)

local WorldCupGroupInfoViewPresentor = class("WorldCupGroupInfoViewPresentor", ViewPresentor)

function WorldCupGroupInfoViewPresentor:ctor()
	WorldCupGroupInfoViewPresentor.super.ctor(self)
end

function WorldCupGroupInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WorldCupGroupInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/worldcup/worldcupgroupinfoview.prefab"
	}
end

function WorldCupGroupInfoViewPresentor:buildViews()
	return {
		WorldCupGroupInfoView.New()
	}
end

return WorldCupGroupInfoViewPresentor
