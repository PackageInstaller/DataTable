-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WTowerViewPresentor.lua

module("logic.extensions.warriortower.view.WTowerViewPresentor", package.seeall)

local WTowerViewPresentor = class("WTowerViewPresentor", ViewWithGuidePresentor)

function WTowerViewPresentor:ctor()
	WTowerViewPresentor.super.ctor(self)
end

function WTowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WTowerViewPresentor:dependWhatResources()
	return {
		"ui/views/warriortower/warriortowerview.prefab"
	}
end

function WTowerViewPresentor:getTempResources()
	local towerId = WTowerModel.instance:getTowerId()

	return {
		WTowerModel.TowerBg[towerId],
		WTowerModel.TowerCellBg[towerId]
	}
end

function WTowerViewPresentor:buildViews()
	local views = {}
	local view = WTowerView.New()
	local view1 = WTowerBoxView.New()

	table.insert(views, view)
	table.insert(views, view1)

	return views
end

return WTowerViewPresentor
