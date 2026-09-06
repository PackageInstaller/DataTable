-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoowarehousePresentor.lua

module("logic.extensions.zoo.view.ZoowarehousePresentor", package.seeall)

local ZoowarehousePresentor = class("ZoowarehousePresentor", ViewPresentor)

function ZoowarehousePresentor:ctor()
	ZoowarehousePresentor.super.ctor(self)
end

function ZoowarehousePresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZoowarehousePresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoowarehouseview.prefab"
	}
end

function ZoowarehousePresentor:buildViews()
	return {
		ZoowarehouseView.New()
	}
end

return ZoowarehousePresentor
