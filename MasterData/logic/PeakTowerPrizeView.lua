-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerPrizeView.lua

module("logic.extensions.peaktower.view.PeakTowerPrizeView", package.seeall)

local PeakTowerPrizeView = class("PeakTowerPrizeView", ViewComponent)
local TYPE_BASIC = 1
local TYPE_LEGEND = 2

function PeakTowerPrizeView:ctor()
	PeakTowerPrizeView.super.ctor(self)
end

function PeakTowerPrizeView:unbindEvents()
	PeakTowerPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLegend)
	GameUtil.rmClickHandler(self._btnBasic)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function PeakTowerPrizeView:bindEvents()
	PeakTowerPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLegend, self._onClickLegend, self)
	GameUtil.addClickHandler(self._btnBasic, self._onClickBasic, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function PeakTowerPrizeView:buildUI()
	PeakTowerPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnLegend = self:getGo("btnLegend")
	self._imageChangeLegend = self._btnLegend:GetComponent(ComponentType.UIChangeGroup)
	self._btnBasic = self:getGo("btnBasic")
	self._imageChangeBasic = self._btnBasic:GetComponent(ComponentType.UIChangeGroup)
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._viewport = self:getGo("tableview/viewport")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemTablecell = self:getGo("itemTablecell")
	self._txtScore = self:getTxt("txtScore")
	self._btnOneKey = self:getGo("btnOneKey")
end

function PeakTowerPrizeView:onExit()
	PeakTowerPrizeView.super.onExit(self)
end

function PeakTowerPrizeView:onEnter()
	PeakTowerPrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PeakTowerInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._curType = TYPE_BASIC
	self._itemTableListDir = {}
	self._weekId = PeakTowerController.instance:getCurWeekId(self._activityId)

	self:_refreshView()
end

function PeakTowerPrizeView:_refreshView()
	self._imageChangeLegend:SetState(self._curType and self._curType == TYPE_LEGEND and 1 or 0)
	self._imageChangeBasic:SetState(self._curType and self._curType == TYPE_BASIC and 1 or 0)

	self._totalScore = 0
	self._maxGainProgrressId = 0

	local prizeList = {}

	if self._curType == TYPE_BASIC then
		self._totalScore = PeakTowerController.instance:getAllBasicScore(self._activityId)
		prizeList = PeakTowerConfig.instance:getBasicProgressPrizeCfgs(self._activityId, self._weekId)
		self._maxGainProgrressId = PeakTowerModel.instance:getMaxGainBasicProgressId(self._activityId)
	elseif self._curType == TYPE_LEGEND then
		self._totalScore = PeakTowerController.instance:getAllLegendScore(self._activityId)
		prizeList = PeakTowerConfig.instance:getLegendProgressPrizeCfgs(self._activityId, self._weekId)
		self._maxGainProgrressId = PeakTowerModel.instance:getMaxGainLegendProgressId(self._activityId)
	end

	local isCanGet = false

	if prizeList then
		for i, v in ipairs(prizeList) do
			if v.progressId > self._maxGainProgrressId and v.score <= self._totalScore then
				isCanGet = true

				break
			end
		end

		GameUtil.SetActive(self._btnOneKey, isCanGet)
		self._tableList:reloadData(prizeList)
	else
		GameUtil.SetActive(self._btnOneKey, false)
		self._tableList:reloadData({})
		printError(">>>>>>>>>>>>>>>>>>>无对应周配置，周id:" .. self._weekId .. ">>>>>>>>>>>")
	end

	if self._maxGainProgrressId < #prizeList then
		self._tableList:MoveCellToCenter(self._maxGainProgrressId)
	else
		self._tableList:MoveCellToCenter(self._maxGainProgrressId - 1)
	end

	self._txtScore.text = langPara("当前分数：<color=#FF2E2EFF>%d</color>", self._totalScore)
end

function PeakTowerPrizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local itemTableView = goutil.findChild(go, "rewardView")
	local clipGo = goutil.findChild(go, "rewardView/Viewport")
	local txtScore = goutil.findChildTextComponent(go, "txtDesc")
	local isGain = data.progressId <= self._maxGainProgrressId
	local isCanGet = not isGain and data.score <= self._totalScore

	txtScore.text = data.score

	local prizeArray = string.split(data.prize, "#")
	local list = {}

	for i, v in ipairs(prizeArray) do
		table.insert(list, {
			prize = v,
			isCanGet = isCanGet,
			isGain = isGain,
			progressId = data.progressId,
			clipGo = clipGo
		})
	end

	local itemTableList = self._itemTableListDir[itemTableView]

	if not itemTableList and itemTableView and self._itemTablecell then
		itemTableList = ScrollerList.create(itemTableView, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		itemTableList:dragNotifyParent()

		self._itemTableListDir[itemTableView] = itemTableList
	end

	itemTableList:reloadData(list)
end

function PeakTowerPrizeView:_clearCell(cell)
	local go = cell.gameObject
	local itemTableView = goutil.findChild(go, "rewardView")

	if self._itemTableListDir[itemTableView] then
		self._itemTableListDir[itemTableView]:dispose()

		self._itemTableListDir[itemTableView] = nil
	end
end

function PeakTowerPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject
	local prizeCon = goutil.findChild(go, "prizeCon")
	local effectGo = goutil.findChild(go, "effectGo")
	local gainGo = goutil.findChild(go, "gain")

	self:stopViewEffectUniGo(effectGo)

	if data.isCanGet == true then
		local effName = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		self:playViewEffectUniGo(effName, effectGo, self._viewport, true)
	end

	GameUtil.SetActive(gainGo, data.isGain)
	MaterialMgr.resetAll(prizeCon)
	MaterialMgr.setCellByCfg(data.prize, prizeCon)
end

function PeakTowerPrizeView:_clearItemCell(cell)
	local go = cell.gameObject
	local prizeCon = goutil.findChild(go, "prizeCon")
	local effectGo = goutil.findChild(go, "effectGo")

	self:stopViewEffectUniGo(effectGo)
	MaterialMgr.resetAll(prizeCon)
end

function PeakTowerPrizeView:_onClickLegend()
	self._curType = TYPE_LEGEND

	self:_refreshView()
end

function PeakTowerPrizeView:_onClickBasic()
	self._curType = TYPE_BASIC

	self:_refreshView()
end

function PeakTowerPrizeView:_onClickOneKey()
	PeakTowerAgent.instance:sendPM_PeakTowerGainProgressPrizeReq(self._activityId, self._curType)
end

return PeakTowerPrizeView
