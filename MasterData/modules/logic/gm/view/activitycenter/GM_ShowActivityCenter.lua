-- chunkname: @modules/logic/gm/view/activitycenter/GM_ShowActivityCenter.lua

module("modules.logic.gm.view.activitycenter.GM_ShowActivityCenter", package.seeall)

local GM_ShowActivityCenter = class("GM_ShowActivityCenter")

function GM_ShowActivityCenter:ctor()
	local requestDict = {
		{
			"OdysseyRpc",
			"sendOdysseyGetInfoRequest"
		},
		{
			"FurnaceTreasureRpc",
			"sendGetAct147InfosRequest"
		},
		{
			"Activity123Rpc",
			"sendGet123InfosRequest"
		},
		{
			"Activity217Rpc",
			"sendGet217InfosRequest"
		},
		{
			"Activity101Rpc",
			"sendGet101InfosRequest"
		},
		{
			"Activity212Rpc",
			"sendGetAct212InfoRequest"
		},
		{
			"Activity225Rpc",
			"sendGetAct225InfoRequest"
		},
		{
			"Activity154Rpc",
			"sendGet154InfosRequest"
		},
		{
			"Activity158Rpc",
			"sendGet158InfosRequest"
		},
		{
			"Activity218Rpc",
			"sendGet218InfoRequest"
		},
		{
			"Activity216Rpc",
			"sendGetAct216InfoRequest"
		},
		{
			"Activity215Rpc",
			"sendGetAct215InfoRequest"
		},
		{
			"Activity153Rpc",
			"sendGet153InfosRequest"
		},
		{
			"Activity226Rpc",
			"sendGet226InfoRequest"
		},
		{
			"Activity152Rpc",
			"sendGet152InfoRequest"
		},
		{
			"Activity166Rpc",
			"sendGet166InfosRequest"
		},
		{
			"Activity224Rpc",
			"sendGet224InfoRequest"
		},
		{
			"Activity223Rpc",
			"sendGetAct223InfoRequest"
		},
		{
			"Activity136Rpc",
			"sendGet136InfoRequest"
		}
	}

	self._funcDict = {}

	for _, v in ipairs(requestDict) do
		local key = string.format("%s|%s", v[1], v[2])

		if _G[v[1]] then
			self._funcDict[key] = _G[v[1]].instance[v[2]]
		else
			logError(key)
		end
	end
end

function GM_ShowActivityCenter:_setFunc()
	for key, value in pairs(self._funcDict) do
		local split = string.split(key, "|")

		if _G[split[1]] and _G[split[1]].instance[split[2]] then
			_G[split[1]].instance[split[2]] = function()
				return
			end
		end
	end
end

function GM_ShowActivityCenter:_resetFunc()
	for key, value in pairs(self._funcDict) do
		local split = string.split(key, "|")

		if _G[split[1]] and _G[split[1]].instance[split[2]] then
			_G[split[1]].instance[split[2]] = value
		end
	end
end

function GM_ShowActivityCenter:setOn(isOn)
	if isOn then
		self:_setFunc()

		if not self._actCos then
			self._actCos = {}

			for _, co in ipairs(lua_activity.configList) do
				if co.centerId ~= 0 then
					table.insert(self._actCos, co)
				end
			end
		end

		for _, co in ipairs(self._actCos) do
			local activityInfo = ActivityModel.instance:getActivityInfo()[co.id]

			if activityInfo and not ActivityHelper.isOpen(co.id) then
				local now = ServerTime.now() * 1000

				activityInfo.startTime = now - 1
				activityInfo.endTime = TimeUtil.maxDateTimeStamp * 1000
				activityInfo.online = true
			end
		end

		GMRpc.instance:sendGMRequest("add turnback 3")
		GMRpc.instance:sendGMRequest("set turnbackLeaveTime 2024-1-1 05:00:00")
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState)
	else
		self:_resetFunc()
		ActivityRpc.instance:sendGetActivityInfosRequest()
	end

	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_GameView_OnClickSwitchMode)
end

return GM_ShowActivityCenter
