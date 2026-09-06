-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/miracledishitian/MiracleDiShiTianMainView.lua

module("logic.extensions.watertianyan.view.miracledishitian.MiracleDiShiTianMainView", package.seeall)

local MiracleDiShiTianMainView = class("MiracleDiShiTianMainView", WaterTianYanMainView)

function MiracleDiShiTianMainView:_getActivityId()
	return WaterTianYanModel.instance:getQiJiDiShiTianActivityId()
end

return MiracleDiShiTianMainView
