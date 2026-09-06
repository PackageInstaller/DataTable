-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterAlchemyMMBookView.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterAlchemyMMBookView", package.seeall)

local DreamTeamChapterAlchemyMMBookView = class("DreamTeamChapterAlchemyMMBookView", ViewComponent)

function DreamTeamChapterAlchemyMMBookView:ctor()
	DreamTeamChapterAlchemyMMBookView.super.ctor(self)
end

function DreamTeamChapterAlchemyMMBookView:unbindEvents()
	DreamTeamChapterAlchemyMMBookView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DreamTeamChapterAlchemyMMBookView:bindEvents()
	DreamTeamChapterAlchemyMMBookView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DreamTeamChapterAlchemyMMBookView:buildUI()
	DreamTeamChapterAlchemyMMBookView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._itemCell = self:getGo("itemCell")
	self._title = self:getGo("tableview/tablecell/title")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
end

function DreamTeamChapterAlchemyMMBookView:onExit()
	DreamTeamChapterAlchemyMMBookView.super.onExit(self)
	self._scrollList:dispose()
end

function DreamTeamChapterAlchemyMMBookView:onEnter()
	DreamTeamChapterAlchemyMMBookView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 595001
	end

	self._rowNum = 5
	self._itemInterval = 5
	self._offsetY = 20
	self._bgGoExY = 9
	self._itemCellWidth = GameUtil.getWidth(self._itemCell)
	self._itemCellHeight = GameUtil.getHeight(self._itemCell)
	self._tableViewWidth = GameUtil.getWidth(self._tableview)
	self._titleHeight = GameUtil.getHeight(self._title)
	self._actCfg = DreamTeamChapterConfig.instance:getActivityCfg(self._activityId)

	if self._actCfg then
		self._qualityShowTitleList = self._actCfg.qualityShowTitleList or {}
	end

	self._info = DreamTeamChapterModel.instance:getInfo(self._activityId)

	if self._info then
		self._hasSmeltPotion = self._info.hasSmeltPotion or {}
	end

	self:_createSortTypeDataMap()
	self._scrollList:reloadData(self._actCfg.qualityShowTitleList)
end

function DreamTeamChapterAlchemyMMBookView:_updateCell(view, cell, data)
	local itemListGo = goutil.findChild(cell, "itemList")
	local bgGo = goutil.findChild(cell, "bg")
	local txtTitle = goutil.findChildTextComponent(cell, "title/txt")
	local dataList = self._scrollDataMap[data]
	local dataNum = #dataList
	local curChildNum = itemListGo.transform.childCount

	for i = 1, curChildNum do
		local go = itemListGo.transform:GetChild(i - 1).gameObject
		local canShow = i <= dataNum

		GameUtil.SetActive(go, canShow)
	end

	if curChildNum < dataNum then
		for i = curChildNum + 1, dataNum do
			local go = goutil.cloneAndSetParent(self._itemCell, itemListGo.transform)
			local x = (i - 1) % self._rowNum + 1
			local y = math.ceil(i / self._rowNum)
			local xPos = (self._itemInterval + self._itemCellWidth) * (x - 1)
			local yPos = -(self._itemInterval + self._itemCellHeight) * (y - 1)

			GameUtil.setLocalPos(go, xPos, yPos, 0)
			GameUtil.SetActive(go, true)
		end
	end

	local rowNum = math.ceil(dataNum / self._rowNum)
	local childsHeight = rowNum * self._itemCellHeight + (rowNum - 1) * self._itemInterval + self._bgGoExY

	GameUtil.setHeight(bgGo, childsHeight)

	txtTitle.text = string.format(lang("%s级药水"), data)

	self:_updateItemCell(itemListGo, dataList, data)
end

function DreamTeamChapterAlchemyMMBookView:_clearCell(cell)
	local itemList = goutil.findChild(cell, "itemList")
	local curChildNum = itemList.transform.childCount

	for i = curChildNum, 1, -1 do
		local go = itemList.transform:GetChild(i - 1).gameObject
		local item = goutil.findChild(go, "item")

		MaterialMgr.resetAll(item)
		goutil.destroy(go)
	end
end

function DreamTeamChapterAlchemyMMBookView:_updateItemCell(itemListGo, dataList, prizeType)
	for i, cfg in ipairs(dataList) do
		local go = itemListGo.transform:GetChild(i - 1).gameObject
		local item = goutil.findChild(go, "item")
		local lock = goutil.findChild(go, "lock")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local txtScore = goutil.findChildTextComponent(go, "txtScore")
		local isLock = not table.indexof(self._hasSmeltPotion, cfg.potionId)
		local materialStr = cfg.materialStr
		local matName = MaterialMgr.getMaterialsNameByCfg(materialStr)
		local proxy = MaterialMgr.setCellByCfg(materialStr, item)

		txtName.text = matName
		txtScore.text = string.format("+%s", cfg.successScore)

		GameUtil.SetActive(lock, isLock)
	end
end

function DreamTeamChapterAlchemyMMBookView:_getCellSize(view, index)
	local showType = self._qualityShowTitleList[index + 1]

	if not self._scrollDataMap[showType] then
		local dataList = {}
		local dataNum = #dataList
		local rowNum = math.ceil(dataNum / self._rowNum)
		local height = self._titleHeight + rowNum * self._itemCellHeight + (rowNum - 1) * self._itemInterval + self._offsetY

		return self._tableViewWidth, height
	end
end

function DreamTeamChapterAlchemyMMBookView:_createSortTypeDataMap()
	local drugCfgs = DreamTeamChapterConfig.instance:getAlchemyPotionCfgs(self._activityId)

	self._scrollDataMap = {}

	for i, showType in ipairs(self._qualityShowTitleList) do
		self._scrollDataMap[showType] = {}
	end

	for i, cfg in ipairs(drugCfgs) do
		local showType = self._qualityShowTitleList[cfg.quality]

		table.insert(self._scrollDataMap[showType], cfg)
	end
end

return DreamTeamChapterAlchemyMMBookView
