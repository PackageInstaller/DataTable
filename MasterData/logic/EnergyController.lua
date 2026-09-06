-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/energy/controller/EnergyController.lua

module("logic.extensions.energy.controller.EnergyController", package.seeall)

local EnergyController = class("EnergyController", BaseController)

function EnergyController:ctor()
	EnergyController.super.ctor(self)
end

function EnergyController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._sendGetAllEnergyInfo, self)
	EnergyAgent.instance:addListener(EnergyAgent.PM_GetEnergyInfoRes, self._handleGetEnergyInfoRes, self)
	EnergyAgent.instance:addListener(EnergyAgent.PM_BuyEnergyRes, self._handleBuyEnergyRes, self)
	EnergyAgent.instance:addListener(EnergyAgent.PM_NotifyEnergyChangeRes, self._notifyChange, self)
	EnergyAgent.instance:addListener(EnergyAgent.PM_GetAllEnergyInfoRes, self._handlePM_GetAllEnergyInfoRes, self)
	GlobalDispatcher:addListener(EnergyModel.ENERGYMODEL_UPDATEENERGYLIST, self._registerEnergyMonitor, self)
end

function EnergyController:onReset()
	return
end

function EnergyController:loadEnergy()
	self:_sendGetAllEnergyInfo()
end

function EnergyController:_sendGetEnergyInfoReq(id, callback)
	EnergyAgent.instance:sendPM_GetEnergyInfoReq(id)
end

function EnergyController:_handleGetEnergyInfoRes(status, msg)
	if status == 0 and msg then
		EnergyModel.instance:setEnergyInfo(msg.info)
		GlobalDispatcher:dispatch(GlobalNotify.UpdataEnergyCount, checknumber(msg.info.id))
	end
end

function EnergyController:_sendGetAllEnergyInfo()
	EnergyAgent.instance:sendPM_GetAllEnergyInfoReq()
end

function EnergyController:_handlePM_GetAllEnergyInfoRes(status, msg)
	if status == 0 and msg then
		EnergyModel.instance:setAllEnergyInfo(msg.infos)
	end
end

function EnergyController:openBuyView(matId, titleStr)
	local energyData = EnergyConfig.instance:getEnergyCfg(matId)
	local dailyBuyTimes = -1
	local energyList = EnergyModel.instance:getEnergyList()

	for k, v in ipairs(energyList) do
		if v.id == matId then
			dailyBuyTimes = v.dailyBuyTimes
		end
	end

	if dailyBuyTimes >= 0 and energyData then
		local buyPlanId = energyData.buyPlanId

		if buyPlanId > 0 then
			if GameUtil.getTimePeriod(energyData.unlockTime, nil) ~= GameUtil.inTimePeriod then
				FloatWordMgr.instance:show(GameUtil.formatTimeString("%m月%d日%H时后开启购买", energyData.unlockTime))

				return
			end

			local buyCfgs = EnergyConfig.instance:getEnergyBuyCfgList(buyPlanId)

			if dailyBuyTimes < #buyCfgs then
				local buyCfg = buyCfgs[dailyBuyTimes + 1]
				local price = string.split(buyCfg.consume, ":")[3]
				local reTime = ""
				local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(energyData.recoveryEfficiency)
				local timeList = {
					day,
					hour,
					min,
					sec
				}
				local uList = {
					"天",
					"小时",
					"分钟",
					"秒"
				}

				for idx, v in ipairs(timeList) do
					if v > 0 then
						reTime = v == 1 and string.format("%s%s", reTime, uList[idx]) or string.format("%s%d%s", reTime, v, uList[idx])
					end
				end

				local str = langPara("%s每%s恢复%s点\n\n确定要花费<color=#EB4642FF>%s钻石</color>，购买<color=#EB4642FF>%s点%s</color>？\n每日限购<color=#EB4642FF>%s次</color>，当前第<color=#EB4642FF>%s次</color>", energyData.name, reTime, energyData.unit, price, buyCfg.gainNum, energyData.name, #buyCfgs, dailyBuyTimes + 1)
				local tipTitle = titleStr or lang("tip")

				TipsFacade.instance:openPopupWindow(tipTitle, str, function()
					EnergyAgent.instance:sendPM_BuyEnergyReq(matId, dailyBuyTimes + 1)
				end, function()
					return
				end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
			else
				FloatWordMgr.instance:show("今日购买次数已达上限")
			end
		else
			FloatWordMgr.instance:show(lang("缺少能量，无法进行挑战"))
		end
	end
end

function EnergyController:_handleBuyEnergyRes(status, msg)
	if status == 0 and msg then
		EnergyModel.instance:setEnergyInfo(msg.info)
		GlobalDispatcher:dispatch(GlobalNotify.UpdataEnergyCount, checknumber(msg.info.id))
	end
end

function EnergyController:_notifyChange(status, msg)
	if status == 0 and msg then
		EnergyModel.instance:setEnergyLeftTime(msg)
		GlobalDispatcher:dispatch(GlobalNotify.UpdataEnergyCount, checknumber(msg.id))
	end
end

function EnergyController:openEnergyJump(matId)
	local data = MaterialMgr.getMatCfg(MatType.ACTIVITY_ENERGY, matId)

	if data.buyPlanId > 0 then
		self:openBuyView(matId)
	elseif not string.nilorempty(data.source) then
		TipsFacade.instance:openItemSourceView(data.source)
	end
end

function EnergyController:isNeedBtnAdd(matId)
	local isNeed = false
	local data = MaterialMgr.getMatCfg(MatType.ACTIVITY_ENERGY, matId)

	if data.buyPlanId > 0 then
		isNeed = true
	elseif not string.nilorempty(data.source) then
		isNeed = true
	end

	return isNeed
end

function EnergyController:_registerEnergyMonitor()
	self._energyList = EnergyModel.instance:getEnergyList()
	self._timeStep = 4

	local lastTime = ServerTime.nowServerLook()

	self._eTimeList = {}

	for idx, v in ipairs(self._energyList) do
		self._eTimeList[idx] = {}
		self._eTimeList[idx].lastTime = lastTime

		if EnergyConfig.instance:getEnergyCfg(v.id) == nil then
			printError("缺失配置! (y运营-能量.xlsx | id = v.id )")
		end
	end

	removetimer(self._countDown, self)
	settimer(self._timeStep, self._countDown, self, true)
end

function EnergyController:_countDown()
	if self._energyList == nil or #self._energyList <= 0 then
		return
	end

	for idx, v in ipairs(self._energyList) do
		local cfg = EnergyConfig.instance:getEnergyCfg(v.id)

		if cfg then
			local lastTime = self._eTimeList[idx].lastTime
			local curTime = ServerTime.nowServerLook()

			self._eTimeList[idx].lastTime = curTime

			local crossTime = curTime - lastTime

			v.nextLeftTime = v.nextLeftTime - crossTime

			if v.nextLeftTime <= 0 then
				v.nextLeftTime = cfg.recoveryEfficiency

				if v.totalCount < cfg.recoveryLimit then
					v.totalCount = v.totalCount + cfg.unit
				end

				GlobalDispatcher:dispatch(GlobalNotify.UpdataEnergyCount, v.id)
			end
		end
	end
end

function EnergyController:isFullEnergy(energyId)
	local curEnergyNum = self:getEnergyNum(energyId)
	local maxEnergyNum = self:getMaxEnergyNum(energyId)

	return maxEnergyNum <= curEnergyNum
end

function EnergyController:getEnergyNum(energyId)
	return EnergyModel.instance:getCurEnergy(energyId)
end

function EnergyController:getMaxEnergyNum(energyId)
	local energyData = EnergyConfig.instance:getEnergyCfg(energyId)

	return (energyData or nil) and energyData.recoveryLimit
end

EnergyController.instance = EnergyController.New()

return EnergyController
