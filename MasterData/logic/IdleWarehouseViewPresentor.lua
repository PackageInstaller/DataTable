-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/IdleWarehouseViewPresentor.lua

module("logic.extensions.idlegame.view.IdleWarehouseViewPresentor", package.seeall)

local IdleWarehouseViewPresentor = class("IdleWarehouseViewPresentor", ViewPresentor)

function IdleWarehouseViewPresentor:ctor()
	IdleWarehouseViewPresentor.super.ctor(self)
end

function IdleWarehouseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IdleWarehouseViewPresentor:dependWhatResources()
	return {
		"ui/views/idlegame/idlewarehouseview.prefab"
	}
end

function IdleWarehouseViewPresentor:buildViews()
	return {
		IdleWarehouseView.New()
	}
end

return IdleWarehouseViewPresentor
