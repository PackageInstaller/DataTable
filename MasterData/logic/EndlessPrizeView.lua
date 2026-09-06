-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/view/EndlessPrizeView.lua

module("logic.extensions.endlessbattle.view.EndlessPrizeView", package.seeall)

local EndlessPrizeView = class("EndlessPrizeView", TableViewComponent)

function EndlessPrizeView:_getPath()
	return {
		cellPath = "container/content/tablecell",
		viewPath = "container/content/tableview"
	}
end

function EndlessPrizeView:unbindEvents()
	EndlessPrizeView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function EndlessPrizeView:bindEvents()
	EndlessPrizeView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function EndlessPrizeView:buildUI()
	EndlessPrizeView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("container/content/txt_title")
	self._contentRect = self:getGo("container/content"):GetComponent(typeof(UnityEngine.RectTransform))
end

local maxItemNum = 1

function EndlessPrizeView:onEnter()
	EndlessPrizeView.super.onEnter(self)

	self._isNormal = self:getFirstParam() == true
	self._curWaveId = EndlessBattleModel.instance:getCurWaveId()
	self._curMaxStateId = EndlessBattleModel.instance:getMaxStageId()
	self._curStageId = EndlessBattleModel.instance:getDailyMaxStage()

	local dailyState = EndlessBattleModel.instance:getDailyState()

	if dailyState == 2 then
		self._curStageId = self._curMaxStateId
	end

	maxItemNum = 1
	self._curViewDatas = {}

	if self._isNormal then
		self._txtTitle.text = "场次"
		self._curViewDatas = EndlessBattleConfig.instance:getStageCfgsByWaveId(self._curWaveId)

		for _, v in ipairs(self._curViewDatas) do
			local prize = string.split(v.dailyPrize, "#")

			maxItemNum = math.max(maxItemNum, #prize)
		end
	else
		self._txtTitle.text = "波次"
		self._curViewDatas = EndlessBattleConfig.instance:getWaveCfgs()

		table.sort(self._curViewDatas, function(a, b)
			return a.waveId < b.waveId
		end)

		for _, v in ipairs(self._curViewDatas) do
			local prize = string.split(v.firstPassPrize, "#")

			maxItemNum = math.max(maxItemNum, #prize)
		end
	end

	local sizeDelta = self._contentRect.sizeDelta

	self._contentRect.sizeDelta = Vector2.New(205 + maxItemNum * 95, sizeDelta.y)
	self._itemPoints = {}

	self:reloadData()
end

function EndlessPrizeView:_cellSize(view, index)
	return 100, 100
end

function EndlessPrizeView:_updateCell(view, cell, data)
	local container = cell.gameObject
	local txtProgress = goutil.findChildTextComponent(container, "txtProgress")
	local receivedText = ""
	local received = false

	if self._isNormal then
		receivedText = "今日已获得"
		txtProgress.text = string.format("第%d波\n<size=21>第%d场</size>", data.waveId, cell.index + 1)
		received = self._curStageId >= data.stageId
	else
		receivedText = "已获得"
		txtProgress.text = string.format("第%d波", data.waveId)
		received = self._curWaveId > data.waveId or #EndlessBattleConfig.instance:getStageCfgs() == self._curMaxStateId
	end

	if not data.dailyPrize then
		local prizeStr = data.firstPassPrize
		local prizes = string.split(prizeStr or "", "#")
		local gridItems = goutil.findChild(container, "gridItems")

		GameUtil.updateCellsWithCreate(gridItems, prizes, function(cell, prize)
			self:_updateOneItem(cell, prize, received, receivedText)
		end)

		local bgRect = goutil.findChildComponent(container, "bg", typeof(UnityEngine.RectTransform))
	end
end

function EndlessPrizeView:_updateOneItem(item, prize, received, receivedText)
	local itemPoint = goutil.findChild(item, "itemPoint")

	MaterialMgr.setCellByCfg(prize, itemPoint)
	table.insert(self._itemPoints, itemPoint)

	local imgReceived = goutil.findChild(item, "imgReceived")

	imgReceived:SetActive(received)

	local txtReceived = goutil.findChildTextComponent(imgReceived, "Text")

	txtReceived.text = receivedText
end

function EndlessPrizeView:onExit()
	EndlessPrizeView.super.onExit(self)

	for _, v in ipairs(self._itemPoints) do
		MaterialMgr.resetAll(v)
	end

	self._itemPoints = nil
end

return EndlessPrizeView
