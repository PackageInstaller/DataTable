-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\PaintingMaterialChangeDlg.lua

local ResHeroPaintItemConvert = require("ClientData/ResHeroPaintItemConvert")
local ResHero = require("ClientData/ResHero")
local ResInfoNotice = require("ClientData/ResInfoNotice")
local strClassName = "PaintingMaterialChangeDlg"
local PaintingMaterialChangeDlg = Class(strClassName, UIControls.Window)

function PaintingMaterialChangeDlg:ctor()
	self:initUI()
end

function PaintingMaterialChangeDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.textTransNum = UIControls.Label(self, "BgPanel/BgTextRatio/TextRatio")
	self.textNum = UIControls.Label(self, "BgPanel/TransitionPanel/TexNum")
	self.textMaxNum = UIControls.Label(self, "BgPanel/TransitionPanel/TexNum1")
	self.gridAllItems = {}
	self.gridSelectedItems = {}
	self.btnTransition = UIControls.Button(self, "BgPanel/BtnTransition")

	self.btnTransition:addEventClick(self.onBtnTransitionClick)
end

function PaintingMaterialChangeDlg:jumpShow(srcGrid)
	if srcGrid then
		self:onShow(srcGrid.object.id, srcGrid.lackNum, srcGrid.selectHero)
	else
		self:setVisible(false)
	end
end

function PaintingMaterialChangeDlg:onShow(itemId, needNum, filterHero)
	self.filterHero = filterHero
	self.allItems = {}

	local hasDarkTrans = false

	for camp, tInfo in pairs(ResHeroPaintItemConvert) do
		if tInfo[itemId] then
			if camp == Const.CAMP_TYPE.SLIM_SNOW then
				hasDarkTrans = true
			end

			CurAvatar:getHeroPaintMaterial(camp, self.allItems, filterHero)
		end
	end

	self.itemId = itemId
	self.clientItem = BaseObject.GetObject(itemId, 1)
	self.materialGrid = UIControls.getGridChild(self.clientItem, self, "BgPanel/TransitionPanel/GridPanel")

	self.materialGrid:setVisible(true)
	self.materialGrid:setObj(self.clientItem)

	self.materialGrid.mDisableWays = true
	self.needNum = needNum
	self.nowSelectItems = {}

	self.textMaxNum:setText("/" .. self.needNum)

	if hasDarkTrans then
		self.textTransNum:setText(ResInfoNotice[260].content)
	else
		self.textTransNum:setText(ResInfoNotice[259].content)
	end

	for _, item in ipairs(self.allItems) do
		local gridContainer = UIControls.GridMultiContainerChild(self, "BgPanel/CoatingListPanel/Content", "System/Common/Grid/GridMultiContainer", 0, 0, true)

		gridContainer:setObj(item)
		gridContainer:setSelectCallback(Slot(self.selectMaterial, self))
		table.insert(self.gridAllItems, gridContainer)
	end

	self:refreshSelectItemState()
end

function PaintingMaterialChangeDlg:selectMaterial(sender, isAdd)
	if self.selectAllNum >= self.needNum and isAdd then
		MsgManager.notice(Lang.get(56189))
		sender:forceSetNum(sender.selectNum - 1)

		return
	end

	local item = sender.grid.object

	if not self.nowSelectItems[item.id] then
		self.nowSelectItems[item.id] = 0
	end

	self.nowSelectItems[item.id] = sender.selectNum

	self:refreshSelectItemState()
end

function PaintingMaterialChangeDlg:refreshSelectItemState()
	self.selectAllNum = 0

	local selItems = {}

	for itemId, itNum in pairs(self.nowSelectItems) do
		if itNum > 0 then
			local nItem = BaseObject.GetObject(itemId, itNum)

			table.insert(selItems, nItem)

			local heroId = Const.PAINT_ITEM_MAP[itemId]

			if heroId and ResHero[heroId] then
				local camp = ResHero[heroId].camp

				self.selectAllNum = self.selectAllNum + ResHeroPaintItemConvert[camp][self.clientItem.id].exchg_ratio * itNum
			end
		end
	end

	self.textNum:setText(self.selectAllNum)

	for index = #self.gridSelectedItems, #selItems - 1 do
		local newContainer = UIControls.getGridContainer(self, "BgPanel/TransitionListPanel/Content")

		newContainer.mDisableWays = true

		table.insert(self.gridSelectedItems, newContainer)
	end

	for index, cell in ipairs(self.gridSelectedItems) do
		if selItems[index] then
			cell:setVisible(true)
			cell:setObj(selItems[index])

			cell.grid.mEnableTips = false
			cell.grid.mEventClick = Slot(self.onCancelSelectClick, self)
		else
			cell:setVisible(false)
		end
	end
end

function PaintingMaterialChangeDlg:onCancelSelectClick(sender)
	local itemId = sender.object.id

	self.nowSelectItems[itemId] = nil

	for _, gridContainer in ipairs(self.gridAllItems) do
		if gridContainer.grid.object.id == itemId then
			gridContainer:clearSelect()
		end
	end

	self:refreshSelectItemState()
end

function PaintingMaterialChangeDlg:onBtnCloseClick()
	self:setVisible(false)
end

function PaintingMaterialChangeDlg:_realTransition(same_paint_item, paint_item_id)
	self:setVisible(false)
	RPC.heroPaintItemConvert(same_paint_item, paint_item_id, self.filterHero)
end

function PaintingMaterialChangeDlg:onBtnTransitionClick()
	local items = {}

	for itId, itNum in pairs(self.nowSelectItems) do
		if itNum > 0 then
			table.insert(items, {
				id = itId,
				num = itNum
			})
		end
	end

	if next(items) then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ResInfoNotice[261].content, Functor(self._realTransition, self, items, self.itemId))
	else
		MsgManager.notice(Lang.get(55852))
	end
end

return PaintingMaterialChangeDlg
