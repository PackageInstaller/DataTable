-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulMainView.lua

module("logic.extensions.fusionsoul.view.FusionSoulMainView", package.seeall)

local FusionSoulMainView = class("FusionSoulMainView", ViewComponent)
local UIEFFECT_FENWEI = "20250725/rongheliliang/fx_ui_rongheliliang_fw.prefab"
local UIEFFECT_WANCHENG = "20250725/rongheliliang/fx_ui_tubiao_xunhuan.prefab"

function FusionSoulMainView:ctor()
	FusionSoulMainView.super.ctor(self)
end

function FusionSoulMainView:unbindEvents()
	FusionSoulMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCombine)
end

function FusionSoulMainView:bindEvents()
	FusionSoulMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCombine, self._onClickCombine, self)
end

function FusionSoulMainView:buildUI()
	FusionSoulMainView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._energy = self:getGo("energy")
	self._energyIcon = self:getGo("energy/icon")
	self._txtEnergyNum = self:getTxt("energy/txtNum")
	self._txtEnergyTip = self:getTxt("energy/txtTip")
	self._btnPrize = self:getGo("btnPrize")
	self._redPointPrize = self:getGo("btnPrize/redpoint")
	self._btnTip = self:getGo("btnTip")
	self._btnClose = self:getGo("btnClose")
	self._btnCombine = self:getGo("btnCombine")
	self._phaseTableview = self:getGo("phaseTableview")
	self._phaseTablecell = self:getGo("phaseTableview/phaseTablecell")
	self._phaseTableList = ScrollerList.create(self._phaseTableview, self._phaseTablecell, GameUtil.handler(self._updatePhaseCell, self), GameUtil.handler(self._clearPhaseCell, self))
	self._progressBar = self:getSlider("phaseTableview/viewport/content/progressBar")
	self._event = self:getGo("event")
	self._eventCon = self:getGo("event/eventCon")
	self._posRecord = self._event:GetComponent(ComponentType.TestRecordPos)
	self._txtScore = self:getTxt("totalScore/txtScore")
	self._finalPass = self:getGo("finalPass")
	self._txtTime = self:getTxt("time/txtTime")
end

function FusionSoulMainView:onExit()
	FusionSoulMainView.super.onExit(self)
	MaterialMgr.resetAll(self._energyIcon)
	self._phaseTableList:dispose()
	removetimer(self._onClock, self)
	GameUtil.clearCells(self._event, self._clearZoneCell, self, false)
	RedPointController.instance:unregRedPoint(self._redPointPrize)
end

function FusionSoulMainView:onEnter()
	FusionSoulMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FusionSoulGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.UpdataEnergyCount, self._onEnergyChange, self)

	self._activityId = self:getFirstParam()

	if checknumber(self._activityId) == 0 then
		self._activityId = 498001
	end

	self._activityCfg = FusionSoulConfig.instance:getActivityCfg(self._activityId)

	local matType, matId = MaterialMgr.getMatParams(self._activityCfg.energyKey)

	self._energyId = matId
	self._curPhase = -1

	FusionSoulAgent.instance:sendPM_FusionSoulGetInfoReq(self._activityId)
	EnergyAgent.instance:sendPM_GetEnergyInfoReq(self._energyId)
	MaterialMgr.setIcon(self._energyIcon, matType, matId)

	self._targetTime = 0

	settimer(1, self._onClock, self, true)

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:showBlockClue()
	RedPointController.instance:regRedPoint(self._redPointPrize, RedPointModel.ID_FUSION_SOUL_PRIZE)

	local energyCfg = EnergyConfig.instance:getEnergyCfg(self._energyId)

	self._txtEnergyTip.text = langPara("（每%d分钟回复%d点）", energyCfg.recoveryEfficiency / 60, energyCfg.unit)

	self:playViewEffect(UIEFFECT_FENWEI, nil, nil, true)
end

function FusionSoulMainView:_refreshView()
	local curPhase = FusionSoulController.instance:getCurPhase(self._activityId)
	local phaseCfgs = FusionSoulConfig.instance:getPhaseCfgs(self._activityId)

	if curPhase ~= self._curPhase then
		self._curPhase = curPhase

		uGuiUtil.setSpriteToImage(self._bg, nil, phaseCfgs[self._curPhase].bgRes)
	end

	local list = {}
	local scoreList = {}

	for i, v in ipairs(phaseCfgs) do
		if v.clueCount ~= 0 then
			table.insert(list, v)
			table.insert(scoreList, v.clueCount)
		end
	end

	self._curScore = FusionSoulModel.instance:getTotalClueCount(self._activityId)
	self._txtScore.text = langPara("已收集线索：%d", self._curScore)

	self._phaseTableList:reloadData(list)
	self._phaseTableList:updateUnderSlider(self._progressBar, self._curScore, scoreList)

	local zoneCfgs = FusionSoulConfig.instance:getZoneCfgs(self._activityId)
	local zoneIds = {}
	local isPassAllEvent = true

	for i = 1, #zoneCfgs do
		local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, i)
		local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, i, zoneInfo.eventId)

		if eventCfg then
			isPassAllEvent = false
		end

		local checkTime = checknumber(zoneInfo.finishDispatchTimeMillis) / 1000

		if checkTime > ServerTime.now() and (self._targetTime == 0 or checkTime < self._targetTime) then
			self._targetTime = checkTime
		end

		table.insert(zoneIds, i)
	end

	GameUtil.updateCellsList(self._event, self._eventCon, zoneIds, self._updateZoneCell, self)
	self._posRecord:LoadPlan(self._curPhase)
	GameUtil.SetActive(self._finalPass, isPassAllEvent)
end

function FusionSoulMainView:_updateZoneCell(cell, data, index)
	local go = cell.gameObject
	local infoGo = goutil.findChild(go, "info")
	local bgEffectGo = goutil.findChild(infoGo, "bg/effect")
	local btn = goutil.findChild(infoGo, "btn")
	local txtName = goutil.findChildTextComponent(infoGo, "txtName")
	local tagNew = goutil.findChild(infoGo, "tagNew")
	local tagCommit = goutil.findChild(infoGo, "tagCommit")
	local tagDispatch = goutil.findChild(infoGo, "tagDispatch")
	local tagComplete = goutil.findChild(infoGo, "tagComplete")
	local iconGo = goutil.findChild(infoGo, "icon")
	local redPoint = goutil.findChild(infoGo, "redPoint")
	local info = FusionSoulModel.instance:getZoneInfo(self._activityId, data)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, data, info.eventId)

	GameUtil.rmClickHandler(btn)
	uGuiUtil.clearImage(iconGo)

	local isOpen = false

	if eventCfg then
		local isGetUnlockClue = true

		if eventCfg.unlockClueIds then
			for i, v in ipairs(eventCfg.unlockClueIds) do
				if not FusionSoulModel.instance:isGainClue(self._activityId, checknumber(v)) then
					isGetUnlockClue = false

					break
				end
			end
		end

		isOpen = eventCfg.unlockSection <= self._curPhase and isGetUnlockClue and (not eventCfg.finalEvent or FusionSoulController.instance:isUnlockFinalEvent(self._activityId))
	end

	self:stopViewEffectUniGo(bgEffectGo)

	if isOpen == true then
		GameUtil.SetActive(infoGo, true)

		txtName.text = eventCfg.name

		uGuiUtil.setSpriteToImage(iconGo, nil, eventCfg.iconRes)
		GameUtil.addClickHandler(btn, function()
			self:_onClickZone(data)
		end)

		local isNew = FusionSoulController.instance:isNewEvent(self._activityId, data, info.eventId)
		local isCanCommit = FusionSoulController.instance:isCanCommit(self._activityId, data, info.eventId)

		GameUtil.SetActive(tagNew, isNew)
		GameUtil.SetActive(tagCommit, isCanCommit)

		local isComplete = false

		if eventCfg.eventType == FusionSoulController.TYPE_DISPATCH then
			if checknumber(info.finishDispatchTimeMillis) / 1000 > ServerTime.now() then
				GameUtil.SetActive(tagDispatch, true)
			elseif checknumber(info.finishDispatchTimeMillis) > 0 then
				GameUtil.SetActive(tagDispatch, false)

				isComplete = true
			else
				GameUtil.SetActive(tagDispatch, false)
			end
		else
			GameUtil.SetActive(tagDispatch, false)
		end

		GameUtil.SetActive(tagComplete, isComplete)

		if isComplete or isCanCommit then
			self:playViewEffectUniGo(UIEFFECT_WANCHENG, bgEffectGo, nil, true)
		end

		GameUtil.SetActive(redPoint, isNew or isCanCommit or isComplete)
	else
		GameUtil.SetActive(infoGo, false)
	end
end

function FusionSoulMainView:_clearZoneCell(cell, index)
	local go = cell.gameObject
	local infoGo = goutil.findChild(go, "info")
	local iconGo = goutil.findChild(infoGo, "icon")
	local btn = goutil.findChild(infoGo, "btn")

	GameUtil.rmClickHandler(btn)
	uGuiUtil.clearImage(iconGo)
end

function FusionSoulMainView:_updatePhaseCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local uiImageChange = goutil.findChildComponent(go, "img", ComponentType.UIImageSpriteChange)
	local curScore = self._curScore

	txtScore.text = data.clueCount
	txtName.text = data.sectionName

	if curScore >= data.clueCount then
		uiImageChange:SetState(0)
	else
		uiImageChange:SetState(1)
	end
end

function FusionSoulMainView:_clearPhaseCell(cell)
	return
end

function FusionSoulMainView:_onEnergyChange()
	self._txtEnergyNum.text = string.format("%d/%d", EnergyController.instance:getEnergyNum(self._energyId), EnergyController.instance:getMaxEnergyNum(self._energyId))
end

function FusionSoulMainView:_onClock()
	if self._targetTime == 0 then
		return
	end

	if self._targetTime <= ServerTime.now() then
		self._targetTime = 0

		self:_refreshView()
	end
end

function FusionSoulMainView:_onClickZone(zoneId)
	local info = FusionSoulModel.instance:getZoneInfo(self._activityId, zoneId)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, zoneId, info.eventId)

	if eventCfg and eventCfg.unlockSection <= self._curPhase then
		if eventCfg.eventType == FusionSoulController.TYPE_DISPATCH then
			UIStateManager.instance:push(ViewName.FusionSoulDispatchView, self._activityId, zoneId)
		elseif eventCfg.eventType == FusionSoulController.TYPE_BATTLE then
			UIStateManager.instance:push(ViewName.FusionSoulBattleView, self._activityId, zoneId)
		elseif eventCfg.eventType == FusionSoulController.TYPE_MISSION then
			UIStateManager.instance:push(ViewName.FusionSoulMissionView, self._activityId, zoneId)
		elseif eventCfg.eventType == FusionSoulController.TYPE_CHAT then
			UIStateManager.instance:push(ViewName.FusionSoulChatView, self._activityId, zoneId)
		elseif eventCfg.eventType == FusionSoulController.TYPE_FUSION then
			if FusionSoulController.instance:isCollectAllClue(self._activityId) == true then
				UIStateManager.instance:push(ViewName.FusionSoulFinalView, self._activityId, zoneId)
			else
				FloatWordMgr.instance:show(lang("请收集完全部线索"))
			end
		end
	end
end

function FusionSoulMainView:_onClickTip()
	TipsFacade.instance:openRulesView("fusion_soul_rule")
end

function FusionSoulMainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.FusionSoulPrizeView, self._activityId)
end

function FusionSoulMainView:_onClickCombine()
	UIStateManager.instance:push(ViewName.FusionSoulCombineView, self._activityId)
end

function FusionSoulMainView:showBlockClue()
	local blockClue = FusionSoulController.instance:getBlockClue()
	local list = {}

	for k, v in pairs(blockClue) do
		table.insert(list, k)
	end

	if #list > 0 then
		local content = "获得线索"

		for i, v in ipairs(list) do
			local clueCfg = FusionSoulConfig.instance:getClueCfg(self._activityId, v)

			content = langPara("%s【%s】", content, clueCfg.name)
		end

		FloatWordMgr.instance:show(content)
		UIStateManager.instance:push(ViewName.FusionSoulClueTipView, self._activityId, list[1], true)
	end

	FusionSoulController.instance:setBlockClue()
end

return FusionSoulMainView
