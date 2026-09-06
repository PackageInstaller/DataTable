-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfareequiprecycle/view/WelfareequiprecycleView.lua

module("logic.extensions.welfareequiprecycle.view.WelfareequiprecycleView", package.seeall)

local WelfareequiprecycleView = class("WelfareequiprecycleView", ViewComponent)

function WelfareequiprecycleView:ctor()
	WelfareequiprecycleView.super.ctor(self)
end

function WelfareequiprecycleView:unbindEvents()
	WelfareequiprecycleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSwitch)
	GameUtil.rmClickHandler(self._btnSelect)
	GameUtil.rmClickHandler(self._btnJump)

	for i, v in ipairs(self._btnTabList) do
		GameUtil.rmClickHandler(v)
	end
end

function WelfareequiprecycleView:bindEvents()
	WelfareequiprecycleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSwitch, self._onClickSend, self)
	GameUtil.addClickHandler(self._btnSelect, self._onClickSelect, self)
	GameUtil.addClickHandler(self._btnJump, self._onShowPets, self)

	for i, v in ipairs(self._btnTabList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickTab, self, i))
	end
end

function WelfareequiprecycleView:buildUI()
	WelfareequiprecycleView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._btnSwitch = self:getGo("btnSwitch")
	self._btnSelect = self:getGo("btnSelect")
	self._txtSelect = self:getTxt("btnSelect/Text")
	self._txtSwitch = self:getTxt("btnSwitch/txt")
	self._tip = self:getGo("tip")
	self._txtTips = self:getTxt("tip/txtTips")
	self._tableviewTop = self:getGo("artifact/tableview")
	self._emptyTop = self:getGo("artifact/empty")
	self._tableview = self:getGo("recycle/tableview")
	self._itemCell = self:getGo("recycle/itemCell")
	self._empty = self:getGo("recycle/empty")
	self._txtTime = self:getTxt("openTime/txt")
	self._btnTab1 = self:getGo("btnTab1")
	self._btnTab2 = self:getGo("btnTab2")
	self._btnTabList = {}

	table.insert(self._btnTabList, self._btnTab1)
	table.insert(self._btnTabList, self._btnTab2)

	self._btnJump = self:getGo("btnJump")
	self._scrollListTop = ScrollerList.create(self._tableviewTop, self._itemCell, GameUtil.handler(self._updateTopCell, self), GameUtil.handler(self.clearCell, self))
	self._scrollList = ScrollerList.create(self._tableview, self._itemCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	self._scrollListTop:setCenterMode(true)
	self._scrollList:setCenterMode(true)
end

function WelfareequiprecycleView:onExit()
	WelfareequiprecycleView.super.onExit(self)
	self._scrollList:dispose()
	self._scrollListTop:dispose()
	uGuiUtil.clearImage(self._bg.gameObject)
	GlobalDispatcher:removeListener(GlobalNotify.OnWelfareRecycleUpdate, self.onRecycleViewUpdate, self)
end

function WelfareequiprecycleView:onEnter()
	WelfareequiprecycleView.super.onEnter(self)

	self._resident_id = checknumber(WelfareRecycleConfig.instance:getCommonValue("RESIDENT_ID"))
	self._activityId = self._resident_id

	GlobalDispatcher:addListener(GlobalNotify.OnWelfareRecycleUpdate, self.onRecycleViewUpdate, self)
	self:_updateAllList()
	self:_onRefreshUI()
	GameUtil.SetActive(self._btnJump, false)
	GameUtil.SetActive(self._tip, false)

	local imgCfg = WelfareRecycleConfig.instance:getImageById(self._activityId) or {}

	uGuiUtil.setSpriteToImage(self._bg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("welfareequiprecycle", imgCfg.imgBg))

	self._txtSelect.text = imgCfg.txtSelect
	self._txtSwitch.text = imgCfg.txtChange
	self._txtTips.text = imgCfg.desc

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(math.floor(self._activityId / 1000), self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))
end

function WelfareequiprecycleView:onRecycleViewUpdate()
	self:_updateAllList()
	self:_onRefreshUI()
end

function WelfareequiprecycleView:_onShowPets()
	UIStateManager.instance:push(ViewName.WelfareequiprecyclepetsView, self._activityId)
end

function WelfareequiprecycleView:_onClickTab(idx)
	for i, v in ipairs(self._btnTabList) do
		-- block empty
	end

	GameUtil.SetActive(self._btnJump, false)

	if idx == 1 then
		GameUtil.SetActive(self._tip, false)
		self:_onShowPets()
	else
		GameUtil.SetActive(self._tip, true)
	end
end

function WelfareequiprecycleView:_onClickSend()
	local onlyIds = {}
	local map = {}

	for i, mo in ipairs(self._selectList) do
		local type = mo:getMatType()

		map[type] = map[type] or {}

		table.insert(map[type], mo:getId())
		table.insert(onlyIds, mo:getId())
	end

	if #onlyIds == 0 then
		TipsFacade.instance:openCommonTips("暂未放入物品，无法转化噢")
	else
		TipsFacade.instance:openPopupWindow(lang("tip"), "确认消耗选中的道具进行转换吗？", function()
			WelfareRecycleController.instance:sendWelfareRecycle(self._activityId, map)
		end)
	end
end

function WelfareequiprecycleView:_updateAllList()
	local cfg = WelfareRecycleConfig.instance:getReplaceCfgByActId(self._activityId) or {}

	self._itemList = {}

	for type, map in pairs(cfg) do
		local filterPool = {}

		for id, v in pairs(map) do
			filterPool[id] = true
		end

		local list = MaterialMgr.getModelList(type) or {}

		for i, item in ipairs(list) do
			if filterPool[item:getDefineId()] == true and self:_filterType(type, item) then
				table.insert(self._itemList, item)
			end
		end
	end

	self._selectList = {}
end

function WelfareequiprecycleView:_filterType(type, item)
	if type == MatType.Equipment then
		return not item.isWear
	end

	return true
end

function WelfareequiprecycleView:_onClickSelect()
	local limitCount = 100

	UIStateManager.instance:push(ViewName.ItemselectView, self._itemList, GameUtil.handler(self._onSelectList, self), self._selectList, limitCount)
end

function WelfareequiprecycleView:_onSelectList(selectlist)
	self._selectList = selectlist or {}

	self:_onRefreshUI()
end

function WelfareequiprecycleView:_onRefreshUI()
	self._scrollListTop:reloadData(self._selectList)

	local list = self:getRecycleList(self._selectList)

	self._scrollList:reloadData(list)
	GameUtil.SetActive(self._empty, #list == 0)
	GameUtil.SetActive(self._emptyTop, #self._selectList == 0)
end

function WelfareequiprecycleView:_updateTopCell(view, cell, data, tag)
	MaterialMgr.setCellByMo(data, cell)
end

function WelfareequiprecycleView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell)
end

function WelfareequiprecycleView:clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function WelfareequiprecycleView:clearChildren(container)
	local trs = container.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)

		MaterialMgr.resetAll(child)
		UnityEngine.GameObject.Destroy(child.gameObject)
	end

	trs:DetachChildren()
end

function WelfareequiprecycleView:getRecycleList(selectList)
	local itemList = {}

	for i, item in ipairs(selectList) do
		local type = item:getMatType()
		local id = item:getDefineId()
		local cfg = WelfareRecycleConfig.instance:getReplaceCfgById(self._activityId, type, id)

		if cfg then
			table.insert(itemList, cfg.returnMp)
		end
	end

	return (MaterialMgr.combineItemsToList(itemList))
end

return WelfareequiprecycleView
