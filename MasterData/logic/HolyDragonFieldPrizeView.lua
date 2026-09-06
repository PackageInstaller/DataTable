-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldPrizeView.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldPrizeView", package.seeall)

local HolyDragonFieldPrizeView = class("HolyDragonFieldPrizeView", ViewComponent)

function HolyDragonFieldPrizeView:buildUI()
	HolyDragonFieldPrizeView.super.buildUI(self)

	self._customInput = UICustomInput.Get(self.mainGO)

	local prizeScrView = self:getGo("prizeCol/scrView")
	local prizeScrCell = self:getGo("prizeCol/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	local tabScrView = self:getGo("tabCol/scrView")
	local tabScrCell = self:getGo("tabCol/scrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._itemScrollListDic = {}
end

function HolyDragonFieldPrizeView:bindEvents()
	HolyDragonFieldPrizeView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function HolyDragonFieldPrizeView:unbindEvents()
	HolyDragonFieldPrizeView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function HolyDragonFieldPrizeView:onEnter()
	HolyDragonFieldPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = HolyDragonFieldController.instance:getActivityId()
	end

	self:_onUpdate()
end

function HolyDragonFieldPrizeView:onExit()
	HolyDragonFieldPrizeView.super.onExit(self)

	if self._tabScrollerList then
		self._tabScrollerList:dispose()
	end

	if self._prizeScrollerList then
		self._prizeScrollerList:dispose()
	end

	for _, itemScrollList in pairs(self._itemScrollListDic or {}) do
		itemScrollList:dispose()
	end

	table.clear(self._itemScrollListDic)
end

function HolyDragonFieldPrizeView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function HolyDragonFieldPrizeView:_onUpdateData()
	self._tabDataList = {}
	self._prizeDataList = {}

	local fieldDatas = HolyDragonFieldConfig.instance:getFieldDatas(self._activityId)

	for fieldId, fieldData in pairs(fieldDatas or {}) do
		table.insert(self._tabDataList, {
			fieldId = fieldId,
			name = lang(fieldData.nameLangkey),
			rankPlanId = fieldData.rankPlanId
		})
	end

	table.sort(self._tabDataList, function(a, b)
		return a.fieldId < b.fieldId
	end)

	if not self:_hasTabData(self._curTabIdx) then
		self._curTabIdx = #self._tabDataList > 0 and 1 or 0
	end

	self:_buildPrizeDataList()
end

function HolyDragonFieldPrizeView:_onUpdateUI()
	self._tabScrollerList:reloadData(self._tabDataList)
	self._prizeScrollerList:reloadData(self._prizeDataList)
	self._prizeScrollerList:MoveCellToBegin(0)
end

function HolyDragonFieldPrizeView:_updateTabCell(view, cell, data)
	local go = cell.gameObject
	local tabIdx = cell.index + 1
	local txtName = goutil.findChildTextComponent(go, "txtName")

	txtName.text = data.name

	GameUtil.setUIGroupIdx(go, self._curTabIdx == tabIdx and 1 or 0)
	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTab, self, tabIdx))
end

function HolyDragonFieldPrizeView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function HolyDragonFieldPrizeView:_onClickTab(tabIdx)
	self._curTabIdx = tabIdx

	self:_buildPrizeDataList()
	self:_onUpdateUI()
end

function HolyDragonFieldPrizeView:_updatePrizeCell(view, cell, data)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgRank = goutil.findChildComponent(go, "imgRank", ComponentType.UIImageSpriteChange)
	local prizeCom = goutil.findChild(go, "prizeCom")
	local itempos = goutil.findChild(go, "itempos")

	txtRank.text = self:_getRankText(data.rankRange)

	if imgRank then
		local rank = self:_getSingleRank(data.rankRange)
		local isTop3 = rank ~= nil and rank <= 3

		GameUtil.SetActive(imgRank.gameObject, isTop3)

		if isTop3 then
			imgRank:SetState(rank - 1)
		end
	end

	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList == nil then
		itemScrollList = ScrollerList.create(prizeCom, itempos, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		itemScrollList:dragNotifyParent()

		self._itemScrollListDic[go] = itemScrollList
	end

	itemScrollList:reloadData(data.prizeList)
	itemScrollList:MoveCellToBegin(0)
end

function HolyDragonFieldPrizeView:_clearPrizeCell(cell)
	local go = cell.gameObject
	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function HolyDragonFieldPrizeView:_updateItemCell(view, cell, prizeStr)
	MaterialMgr.setCellByCfg(prizeStr, cell.gameObject)
end

function HolyDragonFieldPrizeView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function HolyDragonFieldPrizeView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function HolyDragonFieldPrizeView:_hasTabData(tabIdx)
	return self._tabDataList and self._tabDataList[checknumber(tabIdx)] ~= nil
end

function HolyDragonFieldPrizeView:_buildPrizeDataList()
	table.clear(self._prizeDataList)

	local tabData = self._tabDataList[self._curTabIdx]

	if tabData == nil then
		return
	end

	local prizeDatas = HolyDragonFieldConfig.instance:getScoreRankPrizeDatass(tabData.rankPlanId)

	for _, data in pairs(prizeDatas or {}) do
		table.insert(self._prizeDataList, {
			id = checknumber(data.id),
			rankRange = data.rankRange,
			prizeList = string.split(data.prize, "#")
		})
	end

	table.sort(self._prizeDataList, function(a, b)
		return a.id < b.id
	end)
end

function HolyDragonFieldPrizeView:_getSingleRank(rankRange)
	if type(rankRange) ~= "table" then
		return nil
	end

	local leftRank = checknumber(rankRange[1])
	local rightRank = checknumber(rankRange[2])

	if leftRank > 0 and leftRank == rightRank then
		return leftRank
	end

	return nil
end

function HolyDragonFieldPrizeView:_getRankText(rankRange)
	if type(rankRange) ~= "table" then
		return ""
	end

	local leftRank = checknumber(rankRange[1])
	local rightRank = checknumber(rankRange[2])

	if leftRank <= 0 or rightRank <= 0 then
		return ""
	end

	if leftRank == rightRank then
		return langPara("第%s名", leftRank)
	end

	return langPara("第%s-%s名", leftRank, rightRank)
end

return HolyDragonFieldPrizeView
