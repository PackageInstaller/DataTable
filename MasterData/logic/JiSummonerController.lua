-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/controller/JiSummonerController.lua

module("logic.extensions.jisummoner.controller.JiSummonerController", package.seeall)

local JiSummonerController = class("JiSummonerController", BaseController)

function JiSummonerController:ctor()
	self._viewsInfo = {
		{
			redId = 199,
			bgName = "board_zhsj_06",
			viewName = ViewName.JiSummonerLottery
		},
		{
			redId = 239,
			bgName = "bg_zhsj_01",
			viewName = ViewName.JiSummonerTask
		},
		{
			redId = 175,
			bgName = "bg_zhsj_01",
			viewName = ViewName.JiSummonerBuy
		}
	}
end

function JiSummonerController:onInit()
	JiSummonerController.super.onInit(self)
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)

	self.jiPetRaceId = 16009
end

function JiSummonerController:onReset()
	self.viewOpenIndex = nil
	self._jiSummonerInfo = nil
	self._prizeId = nil
end

function JiSummonerController:_TickDailyRefreshData()
	local actId = JiSummonerConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.JiSummoner) then
		self:csRequestPJGetPosterInfoReq()
	end
end

function JiSummonerController:getJiSummonerInfo(isReset)
	if self._jiSummonerInfo == nil or isReset then
		self._jiSummonerInfo = {}
		self._jiSummonerInfo.activePro = 0
		self._jiSummonerInfo.activePrizeIds = {}
		self._jiSummonerInfo.plotPro = 0
		self._jiSummonerInfo.choPrizeId = nil
	end

	return self._jiSummonerInfo
end

function JiSummonerController:getActiveOrPlotTask(actId, isPlot)
	self:getJiSummonerInfo()

	if isPlot then
		local var_6_0 = JiSummonerConfig.instance:getActivityPlotPrizeCfgs(actId)

		if not var_6_0 then
			var_6_0 = JiSummonerConfig.instance:getActivePrizeCfgs(actId)

			local list = var_6_0

			if list == nil then
				return
			end

			local tempList = {}
			local stage = 2

			for _, cfg in pairs(list) do
				if cfg and checknumber(cfg.activityId) > 0 then
					stage = 2

					if isPlot then
						if cfg.id <= self._jiSummonerInfo.plotPro then
							stage = 3
						elseif cfg.id == self._jiSummonerInfo.plotPro + 1 then
							stage = 1
						end

						table.insert(tempList, {
							id = cfg.id,
							prize = cfg.prize,
							titleStr = cfg.titleStr,
							plotId = cfg.plotId,
							stage = stage
						})
					else
						stage = table.indexof(self._jiSummonerInfo.activePrizeIds, cfg.prizeId) and 3 or self._jiSummonerInfo.activePro >= cfg.progress and 1 or 2

						table.insert(tempList, {
							id = cfg.prizeId,
							prize = string.split(cfg.prize, "#"),
							progress = cfg.progress,
							titleStr = cfg.titleStr,
							descStr = cfg.descStr,
							stage = stage,
							jumpTo = cfg.jumpTo
						})
					end
				end
			end

			if #tempList > 1 then
				if isPlot then
					table.sort(tempList, function(a, b)
						return a.id < b.id
					end)
				else
					table.sort(tempList, function(a, b)
						if a.stage == b.stage then
							return a.id < b.id
						end

						return a.stage < b.stage
					end)
				end
			end

			return tempList
		end
	end
end

function JiSummonerController:getJiSummonerRedpoint()
	for _, info in pairs(self._viewsInfo or {}) do
		if info and checknumber(info.redId) > 0 and self:getLeftTableRed(info.redId) then
			return true
		end
	end

	return false
end

function JiSummonerController:getLeftTableRed(redId)
	redId = checknumber(redId)

	if checknumber(redId) <= 0 then
		return false
	end

	return RedPointModel.instance:isActive(redId)
end

function JiSummonerController:csRequestJiActivityInfoReq()
	JiActivityAgent.instance:sendPM_JiActivityInfoReq()
end

function JiSummonerController:scPushJiActivityInfo(msg)
	self:getJiSummonerInfo(true)

	if msg then
		self._jiSummonerInfo.activePro = checknumber(msg.activeProgress)
		self._jiSummonerInfo.plotPro = checknumber(msg.plotProgress)
		self._jiSummonerInfo.activePrizeIds = {}

		for _, id in pairs(msg.gainActivePrizeIds or {}) do
			if checknumber(id) > 0 then
				table.insert(self._jiSummonerInfo.activePrizeIds, id)
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataJiSummonerInfo)
end

function JiSummonerController:csRequestGainJiActivityActivePrizeReq(prizeId)
	self:getJiSummonerInfo()

	self._jiSummonerInfo.choPrizeId = prizeId

	JiActivityAgent.instance:sendPM_GainJiActivityActivePrizeReq(prizeId)
end

function JiSummonerController:scPushGainJiActivityActivePrize()
	self:getJiSummonerInfo()

	if checknumber(self._jiSummonerInfo.choPrizeId) > 0 then
		table.insert(self._jiSummonerInfo.activePrizeIds, self._jiSummonerInfo.choPrizeId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataJiSummonerInfo)

	self._jiSummonerInfo.choPrizeId = nil
end

function JiSummonerController:csRequestGainJiActivityPlotPrizeReq()
	JiActivityAgent.instance:sendPM_GainJiActivityPlotPrizeReq()
end

function JiSummonerController:scPushGainJiActivityPlotPrize()
	self:getJiSummonerInfo()

	self._jiSummonerInfo.plotPro = checknumber(self._jiSummonerInfo.plotPro) + 1

	GlobalDispatcher:dispatch(GlobalNotify.UpdataJiSummonerInfo)
end

JiSummonerController.instance = JiSummonerController.New()

return JiSummonerController
