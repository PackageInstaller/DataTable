-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/celebratebirthday/view/FoodCookingMenuView.lua

module("logic.extensions.celebratebirthday.view.FoodCookingMenuView", package.seeall)

local FoodCookingMenuView = class("FoodCookingMenuView", ViewComponent)

function FoodCookingMenuView:buildUI()
	FoodCookingMenuView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("tablecell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollrect = self._goTable:GetComponent("ScrollRect")
end

function FoodCookingMenuView:bindEvents()
	FoodCookingMenuView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FoodCookingMenuView:unbindEvents()
	FoodCookingMenuView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FoodCookingMenuView:onExit()
	FoodCookingMenuView.super.onExit(self)
	self._tableView:dispose()
end

function FoodCookingMenuView:onEnter()
	FoodCookingMenuView.super.onEnter(self)

	local dataList = self:_getCurDataList()

	self._tableView:reloadData(dataList)
end

function FoodCookingMenuView:_getCurDataList()
	local dataList = {}
	local temData = {}

	temData.showItem = ""
	temData.cdTime = 0
	temData.itemList = {}
	temData.number = 0

	for k, v in ipairs(self:getFirstParam() or {}) do
		if temData.cdTime > 0 then
			temData.showItem = v.iconRes
			temData.number = #dataList + 1

			table.insert(dataList, temData)

			temData = {}
			temData.showItem = ""
			temData.itemList = {}
			temData.cdTime = 0
		else
			if v.cd > 0 then
				temData.cdTime = v.cd
			end

			table.insert(temData.itemList, v.iconRes)
		end
	end

	return dataList
end

function FoodCookingMenuView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtTime.text = langPara("制作时间：%s分钟", data.cdTime)

	local itemNum = #data.itemList

	GameUtil.setWidth(cell.content, itemNum * 170)

	for i = 1, itemNum do
		local item = goutil.findChild(cell.content, "item_" .. i) or goutil.cloneAndSetParent(cell.item, cell.content.transform, "item_" .. i)

		if not string.nilorempty(data.itemList[i]) then
			local iconPath = GameUrl.getItemIconUrl(data.itemList[i])

			uGuiUtil.setSpriteToImage(item, uGuiUtil.SpriteType.BigBg, iconPath)
			goutil.setActive(item, true)
		end
	end

	if not string.nilorempty(data.showItem) then
		local showIconPath = GameUrl.getItemIconUrl(data.showItem)

		uGuiUtil.setSpriteToImage(cell.showItemIcon, uGuiUtil.SpriteType.BigBg, showIconPath)
	end

	cell.dragExclusive:AddDragListener(self._onDrag, self)
	cell.dragExclusive:AddBeginDragListener(self._onBeginDrag, self)
	cell.dragExclusive:AddEndDragListener(self._onEndDrag, self)

	cell.txtNumber.text = langPara("第%s道", GameUtil.getChineseNumber(data.number))
end

function FoodCookingMenuView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.change = cell.go:GetComponent("UIImageSpriteChange")
	cell.con = goutil.findChild(cell.go, "con")
	cell.showItemIcon = goutil.findChild(cell.con, "showItem/icon")
	cell.txtTime = goutil.findChildTextComponent(cell.con, "showItem/txtTime")
	cell.txtNumber = goutil.findChildTextComponent(cell.con, "showItem/txtNumber")
	cell.content = goutil.findChild(cell.con, "itemList/Viewport/Content")
	cell.item = goutil.findChild(cell.content, "item_1")

	for i = 1, cell.content.transform.childCount do
		local item = goutil.findChild(cell.content, "item_" .. i)

		if item then
			goutil.setActive(item, false)
			uGuiUtil.clearImage(item)
		end
	end

	uGuiUtil.clearImage(cell.showItemIcon)

	cell.dragExclusive = Framework.UIDragTrigger.Get(goutil.findChild(cell.con, "itemList"))

	cell.dragExclusive:RemoveDragListener()
	cell.dragExclusive:RemoveBeginDragListener()
	cell.dragExclusive:RemoveEndDragListener()

	return cell
end

function FoodCookingMenuView:_onDrag(eventData)
	self._scrollrect:OnDrag(eventData)
end

function FoodCookingMenuView:_onBeginDrag(eventData)
	self._scrollrect:OnBeginDrag(eventData)
end

function FoodCookingMenuView:_onEndDrag(eventData)
	self._scrollrect:OnEndDrag(eventData)
end

return FoodCookingMenuView
