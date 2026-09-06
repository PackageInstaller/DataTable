-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulDispatchView.lua

module("logic.extensions.fusionsoul.view.FusionSoulDispatchView", package.seeall)

local FusionSoulDispatchView = class("FusionSoulDispatchView", ViewComponent)

function FusionSoulDispatchView:ctor()
	FusionSoulDispatchView.super.ctor(self)
end

function FusionSoulDispatchView:unbindEvents()
	FusionSoulDispatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function FusionSoulDispatchView:bindEvents()
	FusionSoulDispatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function FusionSoulDispatchView:buildUI()
	FusionSoulDispatchView.super.buildUI(self)

	self._txtDesc = self:getTxt("txtDesc")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtState = self:getTxt("btnSure/txt")
	self._time = self:getGo("time")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableList:setCenterMode(true)

	self._energy = self:getGo("energy")
	self._energyIcon = self:getGo("energy/icon")
	self._txtEnergyNum = self:getTxt("energy/txtNum")
	self._costGo = self:getGo("cost")
	self._costIcon = self:getGo("cost/icon")
	self._txtCost = self:getTxt("cost/txtCost")
end

function FusionSoulDispatchView:onExit()
	FusionSoulDispatchView.super.onExit(self)
	removetimer(self._onClock, self)
	MaterialMgr.resetAll(self._energyIcon)
	MaterialMgr.resetAll(self._costIcon)
	self._tableList:dispose()
end

function FusionSoulDispatchView:onEnter()
	FusionSoulDispatchView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FusionSoulGetInfoRes, self._refreshState, self)
	self.addGEvent(self, GlobalNotify.UpdataEnergyCount, self._onEnergyChange, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])
	self._activityCfg = FusionSoulConfig.instance:getActivityCfg(self._activityId)

	local matType, matId = MaterialMgr.getMatParams(self._activityCfg.energyKey)

	self._energyId = matId

	MaterialMgr.setIcon(self._energyIcon, matType, matId)

	local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, self._zoneId)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, self._zoneId, zoneInfo.eventId)

	self._txtTitle.text = eventCfg.name
	self._txtDesc.text = eventCfg.desc

	self._tableList:reloadData(eventCfg.gainClues)
	MaterialMgr.setIcon(self._costIcon, matType, matId)

	self._txtCost.text = checknumber(eventCfg.energyCost)

	self:_onEnergyChange()
	self:_refreshState()
	FusionSoulController.instance:setNewEvent(self._activityId, self._zoneId, zoneInfo.eventId)
end

function FusionSoulDispatchView:_refreshState()
	local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, self._zoneId)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, self._zoneId, zoneInfo.eventId)

	removetimer(self._onClock, self)

	if checknumber(zoneInfo.finishDispatchTimeMillis) == 0 then
		GameUtil.SetActive(self._costGo, true)

		local timeDesc = GameUtil.FormatTimeSymbol(checknumber(eventCfg.eventParam))

		GameUtil.SetGray(self._btnSure, false)

		self._txtState.text = lang("开始派遣")
		self._txtTime.text = langPara("耗时：%s", timeDesc)

		GameUtil.SetActive(self._time, true)
	else
		GameUtil.SetActive(self._costGo, false)

		if checknumber(zoneInfo.finishDispatchTimeMillis) / 1000 <= ServerTime.now() then
			GameUtil.SetGray(self._btnSure, false)

			self._txtState.text = lang("完成派遣")

			GameUtil.SetActive(self._time, false)
		else
			self._targetTime = checknumber(zoneInfo.finishDispatchTimeMillis) / 1000

			self:_onClock()
			settimer(1, self._onClock, self, true)
		end
	end
end

function FusionSoulDispatchView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local clueCfg = FusionSoulConfig.instance:getClueCfg(self._activityId, data)

	txtName.text = clueCfg.name
end

function FusionSoulDispatchView:_clearCell(cell)
	return
end

function FusionSoulDispatchView:_onEnergyChange()
	self._txtEnergyNum.text = string.format("%d/%d", EnergyController.instance:getEnergyNum(self._energyId), EnergyController.instance:getMaxEnergyNum(self._energyId))
end

function FusionSoulDispatchView:_onClock()
	if ServerTime.now() >= self._targetTime then
		GameUtil.SetGray(self._btnSure, false)

		self._txtState.text = lang("完成派遣")

		GameUtil.SetActive(self._time, false)
		removetimer(self._onClock, self)
	else
		GameUtil.SetGray(self._btnSure, true)

		local timer = self._targetTime - ServerTime.now()
		local timeDesc = GameUtil.FormatTimeSymbol(timer)

		self._txtState.text = lang("派遣中")
		self._txtTime.text = langPara("%s", timeDesc)

		GameUtil.SetActive(self._time, true)
	end
end

function FusionSoulDispatchView:_onClickSure()
	local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, self._zoneId)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, self._zoneId, zoneInfo.eventId)

	if checknumber(zoneInfo.finishDispatchTimeMillis) == 0 then
		local activityCfg = FusionSoulConfig.instance:getActivityCfg(self._activityId)
		local matName = MaterialMgr.getMaterialsName(MatType.ACTIVITY_ENERGY, self._energyId)

		if EnergyController.instance:getEnergyNum(self._energyId) >= eventCfg.energyCost then
			local content = langPara("是否确认消耗%s×%d完成该委托？", matName, eventCfg.energyCost)

			TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
				FusionSoulController.instance:sendPM_FusionSoulStartDispatchReq(self._activityId, self._zoneId, zoneInfo.eventId)
				FloatWordMgr.instance:show(lang("派遣成功！"))
			end)
		else
			FloatWordMgr.instance:show(langPara("%s不足，回复后再来吧~", matName))
		end
	elseif checknumber(zoneInfo.finishDispatchTimeMillis) / 1000 <= ServerTime.now() then
		FusionSoulController.instance:sendPM_FusionSoulFinishDispatchReq(self._activityId, self._zoneId, zoneInfo.eventId)
		self:close()
	else
		FloatWordMgr.instance:show("当前任务已在派遣中！")
	end
end

return FusionSoulDispatchView
