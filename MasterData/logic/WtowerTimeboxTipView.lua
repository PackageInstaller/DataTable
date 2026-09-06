-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WtowerTimeboxTipView.lua

module("logic.extensions.warriortower.view.WtowerTimeboxTipView", package.seeall)

local WtowerTimeboxTipView = class("WtowerTimeboxTipView", ViewComponent)

function WtowerTimeboxTipView:ctor()
	WtowerTimeboxTipView.super.ctor(self)
end

function WtowerTimeboxTipView:buildUI()
	WtowerTimeboxTipView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._title = goutil.findChildTextComponent(self.mainGO, "bg/title")
	self._prizeCell = self:getGo("bg/prizeCell")
	self._prizeView = ScrollerList.create(self:getGo("bg/prizeView"), self._prizeCell, GameUtil.handler(self._updateCell, self))

	self._prizeView:regGetCellSize(function()
		return 80, 80
	end)
end

function WtowerTimeboxTipView:bindEvents()
	WtowerTimeboxTipView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function WtowerTimeboxTipView:unbindEvents()
	WtowerTimeboxTipView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function WtowerTimeboxTipView:destroyUI()
	WtowerTimeboxTipView.super.destroyUI(self)
end

function WtowerTimeboxTipView:onEnter()
	WtowerTimeboxTipView.super.onEnter(self)

	self._title.text = WTowerConfig.instance:getParaCfg("timeBox_Title")

	local prizeList = {}
	local addition = VipModel.instance:getOnHookGainRateOfWarriorTower() / 10000

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
					prizeList[itemStr] = prizeList[itemStr] + tonumber(prize[3])
				else
					prizeList[itemStr] = tonumber(prize[3])
					prizeList[#prizeList + 1] = itemStr
				end
			end
		end
	end

	for i = 1, #prizeList do
		prizeList[i] = WTowerController.instance:isFilterReward(prizeList[i]) and prizeList[i] .. ":" .. 0 or prizeList[i] .. ":" .. math.floor(prizeList[prizeList[i]] * addition)
	end

	if prizeList and #prizeList > 0 then
		self._prizeView:reloadData(prizeList)
	else
		FloatWordMgr.instance:show("未配置单位时间产出")
	end

	self._firstParam = self:getFirstParam()
end

function WtowerTimeboxTipView:onEnterFinished()
	WtowerTimeboxTipView.super.onEnterFinished(self)
end

function WtowerTimeboxTipView:onExit()
	WtowerTimeboxTipView.super.onExit(self)

	if self._firstParam and type(self._firstParam) == "function" then
		self._firstParam()
	end

	self._prizeView:dispose()
end

function WtowerTimeboxTipView:onExitFinished()
	WtowerTimeboxTipView.super.onExitFinished(self)
end

function WtowerTimeboxTipView:_updateCell(view, cell, data)
	local proxy = MaterialMgr.setCellByCfg(data, cell.gameObject)

	GameUtil.setLocalScale(proxy.view.transform, 0.7, 0.7, 1)
end

return WtowerTimeboxTipView
