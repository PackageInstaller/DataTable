-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WtowerfastrevenueView.lua

module("logic.extensions.warriortower.view.WtowerfastrevenueView", package.seeall)

local WtowerfastrevenueView = class("WtowerfastrevenueView", ViewComponent)

function WtowerfastrevenueView:ctor()
	WtowerfastrevenueView.super.ctor(self)
end

function WtowerfastrevenueView:buildUI()
	WtowerfastrevenueView.super.buildUI(self)

	self._content = goutil.findChildTextComponent(self.mainGO, "content")
	self._closeBtn = self:getBtn("closeBtn")
	self._costImg = self:getGo("cost/img")
	self._txtNum = goutil.findChildTextComponent(self.mainGO, "cost/txtNum")
	self._free = self:getGo("cost/free")
	self._fastBtn = self:getBtn("fastBtn")
	self._prizeCell = self:getGo("prizeCell")
	self._prizeView = ScrollerList.create(self:getGo("prizeView"), self._prizeCell, GameUtil.handler(self._updateCell, self))
end

function WtowerfastrevenueView:bindEvents()
	WtowerfastrevenueView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._fastBtn:AddClickListener(self._onClickFast, self)
end

function WtowerfastrevenueView:unbindEvents()
	WtowerfastrevenueView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._fastBtn:RemoveClickListener()
end

function WtowerfastrevenueView:destroyUI()
	WtowerfastrevenueView.super.destroyUI(self)
end

function WtowerfastrevenueView:onEnter()
	WtowerfastrevenueView.super.onEnter(self)

	self._turnTotalTimes, self._turnFreeTimes = WTowerModel.instance:getTimeBoxTimes()

	local _profitCfg = WTowerConfig.instance:getProfitCfg()

	self._remainingTimes = VipModel.instance:getFreeSweepTimesOfWarriorTower() + VipModel.instance:getBuyChallengeTimesOfWarriorTower() - self._turnTotalTimes

	if self._turnFreeTimes > 0 then
		goutil.setActive(self._costImg, false)
		goutil.setActive(self._txtNum.gameObject, false)
		goutil.setActive(self._free, true)
	else
		goutil.setActive(self._costImg, true)
		goutil.setActive(self._txtNum.gameObject, true)
		goutil.setActive(self._free, false)

		if self._remainingTimes > 0 then
			local num = string.split(_profitCfg[self._turnTotalTimes + 1].cost, ":")

			self._txtNum.text = num[3]
		else
			self._txtNum.text = 0
		end

		uGuiUtil.setImageGrayStateRecursive(self._fastBtn.gameObject, self._remainingTimes == 0)
	end

	self._content.text = WTowerConfig.instance:getParaCfg("timeBox_Fast_Content")
	goutil.findChildTextComponent(self.mainGO, "times/value").text = self._remainingTimes

	if self._remainingTimes > 0 then
		goutil.findChildComponent(self.mainGO, "times/value", "UITextColorChange"):SetState(0)
	else
		goutil.findChildComponent(self.mainGO, "times/value", "UITextColorChange"):SetState(1)
		uGuiUtil.setImageGrayStateRecursive(self._fastBtn.gameObject, true)
	end

	local prizeList = {}

	for i = 1, 6 do
		local cfg = WTowerConfig.instance:getCfgById(WTowerModel.instance:getCurLevel(i) - 1, i)
		local prizeStr = false

		if cfg then
			prizeStr = cfg.timeUnitPrize
		end

		if prizeStr then
			for i, value in ipairs(string.split(prizeStr, "#")) do
				local prize = string.split(value, ":")
				local itemStr = prize[1] .. ":" .. prize[2]

				if prizeList[itemStr] then
					prizeList[itemStr] = prizeList[itemStr] + math.floor(tonumber(prize[3]))
				else
					prizeList[itemStr] = tonumber(prize[3])
					prizeList[#prizeList + 1] = itemStr
				end
			end
		end
	end

	local addition = VipModel.instance:getOnHookGainRateOfWarriorTower() / 10000
	local defaultNum = 0

	for i = 1, #prizeList do
		if WTowerController.instance:isFilterReward(prizeList[i]) then
			prizeList[i] = prizeList[i] .. ":" .. defaultNum
		else
			local num = prizeList[prizeList[i]] * WTowerConfig.instance:getParaCfg("profitSpeedTimes")

			prizeList[i] = prizeList[i] .. ":" .. math.floor(num * addition)
		end
	end

	if prizeList and #prizeList > 0 then
		self._prizeView:reloadData(prizeList)
	else
		FloatWordMgr.instance:show("未配置单位时间产出")
	end

	self._firstParam = self:getFirstParam()
end

function WtowerfastrevenueView:onEnterFinished()
	WtowerfastrevenueView.super.onEnterFinished(self)
end

function WtowerfastrevenueView:onExit()
	WtowerfastrevenueView.super.onExit(self)

	if self._firstParam and type(self._firstParam) == "function" then
		self._firstParam()
	end

	self._prizeView:dispose()
end

function WtowerfastrevenueView:onExitFinished()
	WtowerfastrevenueView.super.onExitFinished(self)
end

function WtowerfastrevenueView:_onClickFast()
	if self._remainingTimes > 0 then
		WarriorTowerAgent.instance:sendTurnTimeWarriorTowerReq(self._turnFreeTimes > 0, function()
			WTowerModel.instance:setTimeBoxFreeTimes(self._turnFreeTimes - 1)
			WTowerModel.instance:setTimeBoxTotalTimes(self._turnTotalTimes + 1)
			GlobalDispatcher:dispatch(WTowerModel.FAST_REVENUE_RED)
			self:close()
		end)
	else
		FloatWordMgr.instance:show("无剩余快速收益次数")
	end
end

function WtowerfastrevenueView:_updateCell(view, cell, data)
	local proxy = MaterialMgr.setCellByCfg(data, cell.gameObject)

	GameUtil.setLocalScale(proxy.view.transform, 0.7, 0.7, 1)
end

return WtowerfastrevenueView
