-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulMissionView.lua

module("logic.extensions.fusionsoul.view.FusionSoulMissionView", package.seeall)

local FusionSoulMissionView = class("FusionSoulMissionView", ViewComponent)

function FusionSoulMissionView:ctor()
	FusionSoulMissionView.super.ctor(self)
end

function FusionSoulMissionView:unbindEvents()
	FusionSoulMissionView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function FusionSoulMissionView:bindEvents()
	FusionSoulMissionView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function FusionSoulMissionView:buildUI()
	FusionSoulMissionView.super.buildUI(self)

	self._txtDesc = self:getTxt("txtDesc")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._missionTablecell = self:getGo("missionTableview/missionTablecell")
	self._missionTableview = self:getGo("missionTableview")
	self._missionTableList = ScrollerList.create(self._missionTableview, self._missionTablecell, GameUtil.handler(self._updateMissionCell, self), GameUtil.handler(self._clearMissionCell, self))

	self._missionTableList:setCenterMode(true)

	self._prizeTablecell = self:getGo("prizeTableview/prizeTablecell")
	self._prizeTableview = self:getGo("prizeTableview")
	self._prizeTableList = ScrollerList.create(self._prizeTableview, self._prizeTablecell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeTableList:setCenterMode(true)
end

function FusionSoulMissionView:onExit()
	FusionSoulMissionView.super.onExit(self)
	self._missionTableList:dispose()
	self._prizeTableList:dispose()
end

function FusionSoulMissionView:onEnter()
	FusionSoulMissionView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])

	local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, self._zoneId)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, self._zoneId, zoneInfo.eventId)

	self._txtTitle.text = eventCfg.name
	self._txtDesc.text = eventCfg.desc

	self._prizeTableList:reloadData(eventCfg.gainClues)

	local list = {}
	local array = string.split(eventCfg.eventParam, ",")

	for i, v in ipairs(array) do
		table.insert(list, checknumber(v))
	end

	self._missionTableList:reloadData(list)

	local isAllClueGet = true

	for i, v in ipairs(list) do
		if not FusionSoulModel.instance:isGainClue(self._activityId, v) then
			isAllClueGet = false

			break
		end
	end

	GameUtil.SetGray(self._btnSure, not isAllClueGet)
	FusionSoulController.instance:setNewEvent(self._activityId, self._zoneId, zoneInfo.eventId)
end

function FusionSoulMissionView:_updateMissionCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local uiChangeGroup = go:GetComponent(ComponentType.UIChangeGroup)
	local clueCfg = FusionSoulConfig.instance:getClueCfg(self._activityId, data)
	local imgActiveGo = goutil.findChild(go, "imgActive")

	txtName.text = clueCfg.name

	if FusionSoulModel.instance:isGainClue(self._activityId, data) == true then
		uiChangeGroup:SetState(1)
		GameUtil.SetActive(imgActiveGo, true)
	else
		uiChangeGroup:SetState(0)
		GameUtil.SetActive(imgActiveGo, false)
	end
end

function FusionSoulMissionView:_clearMissionCell(cell)
	return
end

function FusionSoulMissionView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local clueCfg = FusionSoulConfig.instance:getClueCfg(self._activityId, data)

	txtName.text = clueCfg.name
end

function FusionSoulMissionView:_clearPrizeCell(cell)
	return
end

function FusionSoulMissionView:_onClickSure()
	local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, self._zoneId)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, self._zoneId, zoneInfo.eventId)
	local isAllClueGet = true
	local array = string.split(eventCfg.eventParam, ",")

	for i, v in ipairs(array) do
		if not FusionSoulModel.instance:isGainClue(self._activityId, checknumber(v)) then
			isAllClueGet = false

			break
		end
	end

	if isAllClueGet == true then
		FusionSoulController.instance:sendPM_FusionSoulFinishMissionReq(self._activityId, self._zoneId, zoneInfo.eventId)
		self:close()
	else
		FloatWordMgr.instance:show(lang("获得所有线索后才可完成委托噢~"))
	end
end

return FusionSoulMissionView
