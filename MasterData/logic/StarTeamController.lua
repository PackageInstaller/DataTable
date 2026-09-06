-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starteam/controller/StarTeamController.lua

module("logic.extensions.starteam.controller.StarTeamController", package.seeall)

local StarTeamController = class("StarTeamController", BaseController)

function StarTeamController:ctor()
	StarTeamController.super.ctor(self)
end

function StarTeamController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
end

function StarTeamController:onReset()
	self.isDataInited = false
end

function StarTeamController:_reloadData()
	self.isDataInited = false
end

function StarTeamController:getInfo(callback)
	if self.isDataInited then
		GameUtil.callBack(callback)
	else
		StarTeamAgent.instance:sendST_GetMyStarTeamInfoReq(function(msg)
			StarTeamModel.instance:initData(msg)
			GameUtil.callBack(callback)
		end)
	end
end

function StarTeamController:sendGetPrize(idx, callback)
	StarTeamAgent.instance:sendST_GainPrizeReq(idx - 1, function(msg)
		StarTeamModel.instance:setPrize(idx)
		GameUtil.callBack(callback)
	end)
end

StarTeamController.instance = StarTeamController.New()

return StarTeamController
