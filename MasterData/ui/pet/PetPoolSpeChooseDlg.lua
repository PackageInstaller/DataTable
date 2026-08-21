-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPoolSpeChooseDlg.lua

local ResPetGashaponConfig = require("ClientData/ResPetGashaponConfig")
local ResPetGashaponItemNew = require("ClientData/ResPetGashaponItemNew")
local strClassName = "PetPoolSpeChooseDlg"
local PetPoolSpeChooseDlg = Class(strClassName, UIControls.Window)

function PetPoolSpeChooseDlg:ctor()
	self:initUI()
end

function PetPoolSpeChooseDlg:initUI()
	self.itemCells = {}
	self.textRule = UIControls.Label(self, "MainInfoPanel/TextRule")
	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.finalAwardPanel = UIControls.Image(self, "MainInfoPanel/FinalAwardPanel")
end

function PetPoolSpeChooseDlg:setData(id)
	self.gashaponId = id
	self.gashaponData = ResPetGashaponConfig[self.gashaponId]
	self.items = {}
	self.itemIds = {}

	for i, itemId in ipairs(self.gashaponData.items) do
		if CurAvatar:gashaponItemTimeValid(itemId) then
			local num = self.gashaponData.items_num[i]
			local item = BaseObject.GetObject(itemId, num)

			table.insert(self.items, item)
			table.insert(self.itemIds, itemId)
		end
	end

	self.hasNew, self.newItemDict = CurAvatar:checkGashaponItemNew()

	for i, v in pairs(CurAvatar.roleDrawData[Const.DrawTypePet].drawSelect or {}) do
		if v.gashapon_id == self.gashaponId and v.select_item_id and utils.tableIsContainsElement(self.gashaponData.items, v.select_item_id) and CurAvatar:gashaponItemTimeValid(v.select_item_id) then
			self.chooseItemId = v.select_item_id
		end
	end

	self:refreshListPanel()
	self:refreshAwardPanel()
end

function PetPoolSpeChooseDlg:refreshListPanel()
	for i, item in ipairs(self.items) do
		if self.itemCells[i] == nil then
			self.itemCells[i] = UIControls.getGridAwardContainer(self, "MainInfoPanel/AwardChooseList/Content")

			self.itemCells[i]:setVisible(true)
		end

		self.itemCells[i]:setObj(item)

		self.itemCells[i].grid.mDisableWays = true
		self.itemCells[i].grid.mEnableTips = false
		self.itemCells[i].grid.mEventClick = Slot(self.selectItemClick, self)

		if self.chooseItemId and self.chooseItemId == item.id then
			self.itemCells[i]:setState(false, true)
		else
			self.itemCells[i]:setState(false, false)
		end

		self.itemCells[i]:showNewLabel(self.newItemDict[item.id] ~= nil)
	end
end

function PetPoolSpeChooseDlg:refreshAwardPanel()
	if self.chooseItemId then
		if not self.finishItemGrid then
			self.finishItemGrid = UIControls.getGridAwardContainer(self, "MainInfoPanel/FinalAwardPanel")
		end

		local chooseItem

		for i, item in ipairs(self.items) do
			if item.id == self.chooseItemId then
				chooseItem = item
			end
		end

		self.finishItemGrid:setObj(chooseItem)

		self.finishItemGrid.grid.mDisableWays = true

		if self.finishItemGrid.bg1 then
			self.finishItemGrid.bg1:setVisible(false)
		end

		self.finishItemGrid:setVisible(true)
	elseif self.finishItemGrid then
		self.finishItemGrid:setVisible(false)
	end
end

function PetPoolSpeChooseDlg:gridFinalAwardClick(sender)
	local mTipsConfig = CurAvatar.commonAmuletTipsFuncItem
	local tips = UIManager.getUI("petAmuletTips")

	tips:show(sender, mTipsConfig)
	tips:setFuncVisible(false)
end

function PetPoolSpeChooseDlg:selectItemClick(sender)
	if ResPetGashaponItemNew[sender.object.id] then
		self.newItemDict[sender.object.id] = nil

		CurAvatar:seenNewGashaponItem({
			sender.object.id
		})
	end

	if self.chooseItemId and sender.object.id == self.chooseItemId then
		self.chooseItemId = nil
	else
		self.chooseItemId = sender.object.id
	end

	self:refreshListPanel()
	self:refreshAwardPanel()
end

function PetPoolSpeChooseDlg:onBtnConfirmClick()
	if self.chooseItemId then
		RPC.petDrawSelect(self.gashaponId, self.chooseItemId)
	else
		MsgManager.notice(Lang.get(78799))
	end
end

function PetPoolSpeChooseDlg:onBtnCloseClick()
	self:setVisible(false)
end

function PetPoolSpeChooseDlg:onClose()
	if self.hasNew then
		CurAvatar:seenNewGashaponItem(self.itemIds)
	end

	PetPoolSpeChooseDlg.super.onClose(self)
end

return PetPoolSpeChooseDlg
