-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmTaskView.lua

module("logic.extensions.eternalfarm.view.EternalFarmTaskView", package.seeall)

local EternalFarmTaskView = class("EternalFarmTaskView", ViewComponent)

function EternalFarmTaskView:ctor()
	EternalFarmTaskView.super.ctor(self)
end

function EternalFarmTaskView:unbindEvents()
	EternalFarmTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGetItem)
	GameUtil.rmClickHandler(self._btnMatDetail)
	GameUtil.rmClickHandler(self._btnClose)
end

function EternalFarmTaskView:bindEvents()
	EternalFarmTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGetItem, self._onClickBtnGetItem, self)
	GameUtil.addClickHandler(self._btnMatDetail, self._onClickBtnMatDetail, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function EternalFarmTaskView:buildUI()
	EternalFarmTaskView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function EternalFarmTaskView:onExit()
	EternalFarmTaskView.super.onExit(self)
	self._scrollList:dispose()
end

function EternalFarmTaskView:onEnter()
	EternalFarmTaskView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.EternalFarm)
	self._collectCfg = EternalFarmConfig.instance:getCollectPrizeCfg(self._activityId) or {}
	self._itemIds = EternalFarmConfig.instance:getItemIds(self._activityId)
	self._nameDic = EternalFarmConfig.instance:getCollectNames(self._activityId)
	self._itemScrollDic = {}
	self._scrollData = {}

	for i, itemId in ipairs(self._itemIds) do
		local cur = {}

		cur.name = self._nameDic[itemId]
		cur.index = i
		cur.cfg = self._collectCfg[itemId]

		table.insert(self._scrollData, cur)
	end

	self._scrollList:reloadData(self._scrollData)
end

function EternalFarmTaskView:_updateCell(view, cell, data)
	local title = goutil.findChildTextComponent(cell, "txtTitleHead")

	if self._itemScrollDic[cell.gameObject] then
		self._itemScrollDic[cell.gameObject]:dispose()

		self._itemScrollDic[cell.gameObject] = nil
	end

	local itemCell = goutil.findChild(cell, "progressReward/rewardCell")
	local itemview = goutil.findChild(cell, "progressReward/tableview")
	local scrollItemList = ScrollerList.create(itemview, itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	self._itemScrollDic[cell.gameObject] = scrollItemList
	title.text = data.name

	scrollItemList:reloadData(data.cfg)
	scrollItemList:dragNotifyParent()
end

function EternalFarmTaskView:_clearCell(cell)
	self._itemScrollDic[cell.gameObject]:dispose()

	self._itemScrollDic[cell.gameObject] = nil
end

function EternalFarmTaskView:_updateItemCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local txtNum = goutil.findChildTextComponent(cell, "score/txtScore")
	local received = goutil.findChild(cell, "received")
	local matType, matId, matNum = MaterialMgr.getMatParams("10:" .. data.itemId .. ":" .. data.number)
	local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if not data.number then
		local needNum = 0
		local hasGainPrizeIds = EternalFarmModel.instance:hasGainPrizeIds(data.itemId)

		GameUtil.SetActive(received, data.prizeId <= #hasGainPrizeIds)
		MaterialMgr.setCellByCfg(data.prize, item)

		txtNum.text = hasNum .. "/" .. needNum
	end
end

function EternalFarmTaskView:_clearItemCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

return EternalFarmTaskView
