-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastBackpackView.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastBackpackView", package.seeall)

local PanTaoFeastBackpackView = class("PanTaoFeastBackpackView", ViewComponent)

function PanTaoFeastBackpackView:ctor()
	PanTaoFeastBackpackView.super.ctor(self)
end

function PanTaoFeastBackpackView:unbindEvents()
	PanTaoFeastBackpackView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PanTaoFeastBackpackView:bindEvents()
	PanTaoFeastBackpackView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PanTaoFeastBackpackView:buildUI()
	PanTaoFeastBackpackView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtName = self:getTxt("txtName")
	self._iconShowItem = self:getGo("iconShowItem")
	self._nameShowItem = self:getGo("nameShowItem")
	self._txtDescShowItem = self:getTxt("txtDescShowItem")
	self._txtNameShowItem = self:getTxt("nameShowItem/txtName")

	local goTab = self:getGo("tableview")
	local goCell = self:getGo("tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PanTaoFeastBackpackView:onExit()
	PanTaoFeastBackpackView.super.onExit(self)
	self._tableView:dispose()

	self._curSelectSortId = 0
end

function PanTaoFeastBackpackView:onEnter()
	PanTaoFeastBackpackView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastStashToGridRes, self._handleStashToGridRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = PanTaoFeastController.instance:getDefaultActivityId() or 0
	end

	self._curStashId = checknumber(params[2])

	self:_updateUIByCfg()

	local isVaild = self._curStashCfg ~= nil

	if not isVaild then
		printError("无效的暂存区配置:", self._activityId, "stashId:", self._curStashId)
		self:close()

		return
	end

	self:_updateUIByInfo()
	self:_switchSelectSortId(1)
end

function PanTaoFeastBackpackView:_updateUIByCfg()
	self._capacity = 0
	self._curStashCfg = PanTaoFeastConfig.instance:getStashCfg(self._activityId, self._curStashId)

	if self._curStashCfg then
		self._txtName.text = self._curStashCfg.stashName or ""
		self._capacity = checknumber(self._curStashCfg.capacity)
	end
end

function PanTaoFeastBackpackView:_updateUIByInfo()
	self._curElementIdList = self._curElementIdList or {}

	table.clear(self._curElementIdList)

	local stashInfo = PanTaoFeastModel.instance:getStoreElementInfo(self._activityId, self._curStashId)

	if stashInfo then
		if not stashInfo.elementIds then
			do
				local elementIds = {}

				for i = 1, self._capacity do
					local data = {}

					data.sortId = i
					data.elementId = checknumber(elementIds[i])

					table.insert(self._curElementIdList, data)
				end
			end

			if #self._curElementIdList < self._capacity then
				for i = #self._curElementIdList + 1, self._capacity do
					local data = {}

					data.sortId = i
					data.elementId = 0

					table.insert(self._curElementIdList, data)
				end
			end
		end
	end

	self._tableView:reloadData(self._curElementIdList)
end

function PanTaoFeastBackpackView:_handleStashToGridRes()
	self:_updateUIByInfo()
	self:_switchSelectSortId(0)
end

function PanTaoFeastBackpackView:_switchSelectSortId(sortId)
	if self._curSelectSortId == sortId then
		return
	end

	self._curSelectSortId = sortId

	self._tableView:reloadData(self._curElementIdList)

	local data = self._curElementIdList[sortId]
	local elementId = data and checknumber(data.elementId) or 0
	local elementCfg = PanTaoFeastConfig.instance:getElementCfgByElementId(self._activityId, elementId)

	if elementCfg then
		goutil.setActive(self._iconShowItem, true)
		goutil.setActive(self._nameShowItem, true)

		self._txtNameShowItem.text = elementCfg.name or ""
		self._txtDescShowItem.text = elementCfg.showDesc or ""

		local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementId)

		if not GameUtil.isEmptyString(iconPath) then
			local spriteName = GameUrl.getItemIconUrl(iconPath)

			uGuiUtil.setSpriteToImage(self._iconShowItem, uGuiUtil.SpriteType.BigBg, spriteName)
		else
			uGuiUtil.clearImage(self._iconShowItem)
		end
	else
		uGuiUtil.clearImage(self._iconShowItem)
		goutil.setActive(self._iconShowItem, false)
		goutil.setActive(self._nameShowItem, false)

		self._txtNameShowItem.text = ""
		self._txtDescShowItem.text = ""
	end
end

function PanTaoFeastBackpackView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local btn = goutil.findChild(go, "btn")
	local markEmpty = goutil.findChild(go, "markEmpty")
	local markSelect = goutil.findChild(go, "markSelect")
	local elementId = checknumber(data.elementId)
	local isSelected = self._curSelectSortId == data.sortId

	goutil.setActive(markSelect, isSelected)

	local isEmpty = elementId == 0

	goutil.setActive(markEmpty, isEmpty)
	goutil.setActive(icon, not isEmpty)
	uGuiUtil.clearImage(icon)

	if not isEmpty then
		local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementId)

		if not GameUtil.isEmptyString(iconPath) then
			local spriteName = GameUrl.getItemIconUrl(iconPath)

			uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
		end
	end

	GameUtil.addClickHandler(btn, function()
		if isSelected then
			if not isEmpty then
				local hasEmptyGrid = PanTaoFeastGameController.instance:hasEmptyGrid(self._activityId)

				if not hasEmptyGrid then
					TipsFacade.instance:openCommonTips(lang("当前棋盘无空位，请清理后再来取出物品"))

					return
				end

				PanTaoFeastController.instance:stashToGrid(self._activityId, self._curStashId, elementId)
			end
		else
			self:_switchSelectSortId(data.sortId)
		end
	end, self)
end

function PanTaoFeastBackpackView:_clearCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local icon = goutil.findChild(go, "icon")

	GameUtil.rmClickHandler(btn)
	uGuiUtil.clearImage(icon)
end

return PanTaoFeastBackpackView
