-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/controller/WuErLiXiController.lua

module("modules.logic.versionactivity2_4.wuerlixi.controller.WuErLiXiController", package.seeall)

local WuErLiXiController = class("WuErLiXiController", BaseController)

function WuErLiXiController:onInit()
	return
end

function WuErLiXiController:reInit()
	return
end

function WuErLiXiController:addConstEvents()
	return
end

function WuErLiXiController:enterLevelView()
	Activity180Rpc.instance:sendGet180InfosRequest(VersionActivity2_4Enum.ActivityId.WuErLiXi, self._onRecInfo, self)
end

function WuErLiXiController:_onRecInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg.activityId == VersionActivity2_4Enum.ActivityId.WuErLiXi then
		WuErLiXiModel.instance:initInfos(msg.act180EpisodeNO)
		ViewMgr.instance:openView(ViewName.WuErLiXiLevelView)
	end
end

function WuErLiXiController:enterGameView(mapId, data)
	ViewMgr.instance:openView(ViewName.WuErLiXiGameView, mapId, data)
end

WuErLiXiController.instance = WuErLiXiController.New()

return WuErLiXiController
