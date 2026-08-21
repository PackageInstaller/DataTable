-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\OpenChoose\\OpenBoxChooseDlg.lua

local ResColor = require("ClientData/ResColor")
local ResRandClient = require("ClientData/ResRandClient")
local ResClientNotice = require("ClientData/ResClientNotice")
local OpenBoxChooseCell = Class("OpenBoxChooseCell", UIControls.Child)

function OpenBoxChooseCell:ctor()
	self.btnChooseOne = UIControls.Button(self, "BtnConfirm")

	self.btnChooseOne:addEventClick(self.onChooseOneClick)

	self.panelNum = UIControls.Panel(self, "GridNub")
	self.btnNumAdd = UIControls.Button(self, "GridNub/BtnAdd")

	self.btnNumAdd:addEventClick(self.onNumAddClick)

	self.btnNumSub = UIControls.Button(self, "GridNub/BtnMinus")

	self.btnNumSub:addEventClick(self.onNumSubClick)

	self.textNum = UIControls.Label(self, "GridNub/Nubtext/Text")
	self.btnShowNum = UIControls.Button(self, "GridNub/Nubtext")

	self.btnShowNum:addEventClick(self.onShowNumClick)

	self.selectedImg = UIControls.Image(self, "SelectImage")
end

function OpenBoxChooseCell:setData(chooseType, idInfo, index)
	self.index = index
	self.cellMaxNum = nil
	self.item = nil

	if chooseType == Const.ITEM_CHOOSE_GIFT_EQUIP then
		local suitCell = UIConst.BtnChooseEquipSet(self, "GridItem", "System/Bag/BtnChooseEquipSet", 0, 0, true)

		suitCell:setSuitInfo(idInfo[1])

		suitCell.mEventClick = Slot(self.onShowSuitInfo, self)
	else
		self.item = BaseObject.GetObject(idInfo[1], idInfo[2])
		self.itemGrid = UIControls.getGridChild(self.item, self, "GridItem")

		self.itemGrid:setObj(self.item)
		self.itemGrid:setVisible(true)

		self.cellMaxNum = idInfo[3]
	end
end

function OpenBoxChooseCell:refreshGotState()
	if self.item.itemType == Const.ITEM_TYPE_ARTIFACT then
		if self.cellMaxNum and self.cellMaxNum > 0 and CurAvatar:getIsHaveArtifactById(self.item.id) then
			self.itemGrid:setGot(true)

			self.isGot = true
		else
			self.itemGrid:setGot(false)

			self.isGot = false
		end
	elseif self.item.itemType == Const.ITEM_TYPE_SKIN then
		self.itemGrid:refreshGet()

		self.isGot = self.item:isGet() or not self.item:isHeroGet()
	else
		self.isGot = false
	end

	self.btnChooseOne:setVisible(self.totalMaxNum == 1 and not self.isGot)
	self.panelNum:setVisible(self.totalMaxNum ~= 1 and not self.isGot)
end

function OpenBoxChooseCell:onShowSuitInfo(sender)
	self.mParent:onShowSuitInfo(sender)
end

function OpenBoxChooseCell:resetNum(maxNum)
	self.totalMaxNum = maxNum

	self.btnChooseOne:setVisible(maxNum == 1 and not self.isGot)
	self.panelNum:setVisible(maxNum ~= 1 and not self.isGot)

	self.nowNum = 0

	self.textNum:setText(self.nowNum)
	self:refreshCellNum(false)
	self.selectedImg:setVisible(false)
end

function OpenBoxChooseCell:onChooseOneClick()
	self.mParent:onBuyOneClick(self)
end

function OpenBoxChooseCell:onNumAddClick()
	if self.cellMaxNum and self.nowNum >= self.cellMaxNum then
		MsgManager.clientNotice(374)

		return
	end

	if not self.mParent:checkBagEnough() then
		local fullNotice = CurAvatar:getBagFullNotice(Const.GIFT_TYPE_BAG[self.mParent.giftType])

		MsgManager.clientNotice(fullNotice)

		return
	end

	if self.mParent:wantAddOne() then
		self.nowNum = self.nowNum + 1

		self.textNum:setText(self.nowNum)
		self.mParent:refreshNum()
	end

	self.selectedImg:setVisible(self.nowNum > 0 and self.totalMaxNum == 1)
end

function OpenBoxChooseCell:onNumSubClick()
	if self.nowNum > 0 then
		self.nowNum = self.nowNum - 1

		self.textNum:setText(self.nowNum)
		self.mParent:refreshNum()
	end

	self.selectedImg:setVisible(self.nowNum > 0 and self.totalMaxNum == 1)
end

function OpenBoxChooseCell:refreshCellNum(isMax)
	self.btnNumSub:setEnable(self.nowNum > 0)
	self.btnNumAdd:setEnable(not isMax)
end

function OpenBoxChooseCell:onShowNumClick()
	self.mParent:onNumInput(self)
end

function OpenBoxChooseCell:setNowNum(nowNum)
	self.nowNum = nowNum

	self.textNum:setText(self.nowNum)
	self.mParent:refreshNum()
end

local strClassName = "OpenBoxChooseDlg"
local OpenBoxChooseDlg = Class(strClassName, UIControls.Window)

function OpenBoxChooseDlg:ctor()
	self:initUI()
end

function OpenBoxChooseDlg:initUI()
	self.panelBg = UIControls.Panel(self, "BGPanel")

	self.panelBg:setVisible(true)

	self.btnConfirm = UIControls.Button(self, "BGPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtTitle = UIControls.Label(self, "BGPanel/TextTitle")
	self.panelTimes = UIControls.Panel(self, "BGPanel/TextTime")
	self.txtTimes = UIControls.Label(self, "BGPanel/TextTime/Text")
	self.chooseGrids = {}
	self.textDesc = UIControls.Label(self, "BGPanel/BgTextDes/TextDes")
	self.panelDesc = UIControls.Panel(self, "BGPanel/BgTextDes")
	self.btnClickThrough = UIControls.Button(self, "BGPanel/UIClickThrough")

	self.btnClickThrough:addEventClick(self.onThroughClick)

	self.keyboard = UIControls.NumKeyboard(self, "BGPanel/KeyboardNode")

	self.keyboard:setVisible(false)

	self.panelCollectWordsNum = UIControls.Panel(self, "BGPanel/CollectWordsNumPanel")
	self.collectWordsTxtNum = {}

	for i = 1, 5 do
		local txtNum = UIControls.Label(self, "BGPanel/CollectWordsNumPanel/NumPanel" .. i .. "/TextNum")

		table.insert(self.collectWordsTxtNum, txtNum)
	end
end

function OpenBoxChooseDlg:onThroughClick()
	self.panelDesc:setVisible(false)
	self.btnClickThrough:setVisible(false)
end

function OpenBoxChooseDlg:onShowSuitInfo(sender)
	self.textDesc:setText(sender.suitInfo.des or "")
	self.panelDesc:setVisible(true)
	self.btnClickThrough:setVisible(true)

	local pos = sender:getAbsPosition()

	self.panelDesc:setAbsPosition(pos.x, pos.y + 0.7)
end

function OpenBoxChooseDlg:openChoose(itemGift, confirmCB, needIgnoreItemUse, wordsBag)
	self.mConfirmCB = confirmCB
	self.needIgnoreItemUse = needIgnoreItemUse
	self.itemGift = BaseObject.CopyObject(itemGift)
	self.giftType = self.itemGift.resData.extend_args1
	self.maxNum = itemGift.num
	self.bagRemainNum = CurAvatar:getBagBlankByBagType(Const.GIFT_TYPE_BAG[self.giftType])

	self.txtTitle:setText(self.itemGift.name)
	self.txtTimes:setText(itemGift.num)

	self.randIds = {}

	local idxDic = {}

	if self.itemGift.subType == Const.ITEM_STYPE_RAND_LIMIT_SELECT then
		for i, item_id in ipairs(self.itemGift.resData.extend_args3) do
			local limitNum = self.itemGift.resData.extend_args4[i]
			local num = 1

			if self.itemGift.resData.extend_args5 then
				num = self.itemGift.resData.extend_args5[i] or 1
			end

			if limitNum and limitNum > 0 then
				table.insert(self.randIds, {
					item_id,
					num,
					1
				})
			else
				table.insert(self.randIds, {
					item_id,
					num
				})
			end

			idxDic[item_id] = i
		end

		self.inLimitMode = true
		self.maxNum = 1
	else
		for i, random_id in ipairs(self.itemGift.resData.extend_args3) do
			if ClientUtils.IsRandomValid(random_id) then
				local itemId = ResRandClient[random_id].show_ids[1]
				local itemNum = ResRandClient[random_id].show_nums[1]

				table.insert(self.randIds, {
					itemId,
					itemNum
				})

				idxDic[itemId] = i
			end
		end

		self.inLimitMode = false
	end

	self.btnConfirm:setVisible(self.maxNum >= 1)
	self.panelTimes:setVisible(self.maxNum > 1)

	self.cells = {}

	for index = 1, #self.randIds do
		local newCell = OpenBoxChooseCell(self, "BGPanel/ItemList/Content", "System/Common/Grid/GridBoxAwardItem")

		newCell:setVisible(true)
		newCell:setData(self.giftType, self.randIds[index], idxDic[self.randIds[index][1]])
		newCell:resetNum(self.maxNum)
		table.insert(self.cells, newCell)
	end

	self:onRefreshGot()

	if wordsBag then
		self.panelCollectWordsNum:setVisible(true)

		for i = 1, 5 do
			self.collectWordsTxtNum[i]:setText(wordsBag[i].num or 0)
		end
	end
end

function OpenBoxChooseDlg:onRefreshGot()
	if self.inLimitMode then
		for index, cell in ipairs(self.cells) do
			cell:refreshGotState()
		end
	end
end

function OpenBoxChooseDlg:reChooseIfEnough()
	self.inBuying = false
	self.bagRemainNum = CurAvatar:getBagBlankByBagType(Const.GIFT_TYPE_BAG[self.giftType])

	if self.bagRemainNum <= 0 then
		self:setVisible(false)

		return
	end

	self.maxNum = CurAvatar:getItemNumById(self.itemGift.id) or 0

	if self.maxNum <= 0 then
		self:setVisible(false)

		return
	else
		if self.inLimitMode then
			self.maxNum = 1
		end

		self:resetChoose()
		self:onRefreshGot()
	end
end

function OpenBoxChooseDlg:onBtnBlockClick()
	self:setVisible(false)
end

function OpenBoxChooseDlg:onBtnConfirmClick()
	if self.inBuying then
		return
	end

	local lists = {}

	for index, cell in ipairs(self.cells) do
		if cell.nowNum > 0 then
			if cell.item and not self:checkItemNumEnable(cell.item) then
				return
			end

			table.insert(lists, {
				data = {
					id = self.itemGift.id,
					num = cell.nowNum
				},
				param = cell.index
			})
		end
	end

	if #lists > 0 then
		if not self.needIgnoreItemUse then
			RPC.itemUse(lists)
		end

		self.inBuying = true

		if self.mConfirmCB then
			self.mConfirmCB(lists)
		end
	else
		MsgManager.notice(Lang.get(30500))
	end
end

function OpenBoxChooseDlg:checkItemNumEnable(item)
	if item and item.itemType == Const.ITEM_TYPE_ARTIFACT and CurAvatar:getArtifactRemainBlankNum() <= 0 then
		CurAvatar:confirmBagAdd(Const.BAG_TYPE_ARTIFACT)

		return
	end

	return true
end

function OpenBoxChooseDlg:onBuyOneClick(sender)
	if self.inBuying then
		return
	end

	if sender.item and not self:checkItemNumEnable(sender.item) then
		return
	end

	if self.selectedItem ~= nil then
		self.selectedItem:resetNum(self.maxNum)
	end

	self.selectedItem = sender

	self.selectedItem:onNumAddClick()
end

function OpenBoxChooseDlg:resetChoose()
	self.btnConfirm:setVisible(self.maxNum >= 1)
	self.panelTimes:setVisible(self.maxNum > 1)
	self.txtTimes:setText(self.maxNum)

	for index, cell in ipairs(self.cells) do
		cell:resetNum(self.maxNum)
	end

	self.selected = nil
end

function OpenBoxChooseDlg:wantAddOne()
	local num = 0

	for index, cell in ipairs(self.cells) do
		num = num + cell.nowNum
	end

	return num < self.maxNum
end

function OpenBoxChooseDlg:checkBagEnough()
	local num = 0

	for index, cell in ipairs(self.cells) do
		num = num + cell.nowNum
	end

	return num < self.bagRemainNum
end

function OpenBoxChooseDlg:onNumInput(sender)
	local num = 0

	self.selCell = sender

	for index, cell in ipairs(self.cells) do
		if cell ~= self.selCell then
			num = num + cell.nowNum
		end
	end

	if sender.cellMaxNum then
		local keyboardMaxNum = math.min(sender.cellMaxNum, self.maxNum - num, self.bagRemainNum - num)

		self.keyboard:show(Slot(self.onNumChanged, self), sender.nowNum, keyboardMaxNum, 0)
	else
		local keyboardMaxNum = math.min(self.maxNum - num, self.bagRemainNum - num)

		self.keyboard:show(Slot(self.onNumChanged, self), sender.nowNum, keyboardMaxNum, 0)
	end

	local fullNoticeId = CurAvatar:getBagFullNotice(Const.GIFT_TYPE_BAG[self.giftType])

	if ResClientNotice[fullNoticeId] ~= nil and self.bagRemainNum < self.maxNum then
		self.keyboard:setMaxNotice(ResClientNotice[fullNoticeId].notice)
	else
		self.keyboard:setMaxNotice(ResClientNotice[147].notice)
	end

	self.keyboard:setBottom(sender)
end

function OpenBoxChooseDlg:onNumChanged(num)
	if self.selCell then
		self.selCell:setNowNum(num)
	end
end

function OpenBoxChooseDlg:refreshNum()
	local num = 0

	for index, cell in ipairs(self.cells) do
		num = num + cell.nowNum
	end

	for index, cell in ipairs(self.cells) do
		cell:refreshCellNum(num >= self.maxNum)
	end

	self.txtTimes:setText(self.maxNum - num)
end

return OpenBoxChooseDlg
