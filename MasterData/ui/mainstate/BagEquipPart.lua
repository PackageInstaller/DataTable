-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\BagEquipPart.lua

local UIControls = UIControls
local CommonSortPanel = require("UI/Common/CommonSortPanel")
local ResItemSpecialConfig = require("ClientData/ResItemSpecialConfig")
local FILTER_ALL = 0
local MAX_EQUIP_PART = 6
local ONCE_SELL_MAX = 64
local strClassName = "BagEquipPart"
local BagEquipPart = Class(strClassName, UIControls.Child)

function BagEquipPart:ctor()
	self:initUI()
end

local EQUIP_SORT_MAP = {
	{
		name = "sortQuality",
		text = Lang.get(372)
	},
	{
		name = "sortDefineId",
		hide = 1,
		text = Lang.get(51403)
	},
	{
		name = "enhanceLevel",
		text = Lang.get(920)
	},
	{
		name = "suitId",
		text = Lang.get(50273)
	}
}
local EQUIP_SELL_FILTER_MAP = {
	{
		title = Lang.get(372),
		data = {
			{
				Lang.get(3633),
				"quality",
				1
			},
			{
				Lang.get(30445),
				"quality",
				{
					2,
					3
				}
			},
			{
				Lang.get(30446),
				"quality",
				{
					4,
					5
				}
			},
			{
				Lang.get(30447),
				"quality",
				{
					6,
					7
				}
			},
			{
				Lang.get(30448),
				"quality",
				{
					8,
					9
				}
			},
			{
				Lang.get(30456),
				"quality",
				10
			}
		}
	},
	{
		title = Lang.get(920),
		data = {
			{
				Lang.get(30457),
				"enhanceLevel",
				0
			},
			{
				Lang.get(30458),
				"enhanceLevel",
				{
					1,
					3
				}
			},
			{
				Lang.get(30459),
				"enhanceLevel",
				{
					4,
					6
				}
			},
			{
				Lang.get(30460),
				"enhanceLevel",
				{
					7,
					9
				}
			},
			{
				Lang.get(30461),
				"enhanceLevel",
				{
					10,
					12
				}
			}
		}
	}
}

function BagEquipPart:initUI()
	self.cells = {}
	self.gidGridDic = {}
	self.cellGidDic = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "ItemListScroll")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.imgNone = UIControls.Image(self, "ImgNone")
	self.btnFilterAll = UIControls.Button(self, "TabTypePanel/BtnAll")
	self.btnFilterAll.part = FILTER_ALL

	self.btnFilterAll:addEventClick(self.onClickPart)

	self.filterPartBtns = {}
	self.filterPartBtns[FILTER_ALL] = self.btnFilterAll

	for index = 1, MAX_EQUIP_PART do
		local newBtn = UIControls.Button(self, "TabTypePanel/Btn" .. index)

		newBtn.part = index

		newBtn:addEventClick(self.onClickPart)
		table.insert(self.filterPartBtns, newBtn)
	end

	self.filter = FILTER_ALL

	for index, btn in pairs(self.filterPartBtns) do
		btn:setEnable(self.filter ~= index)
	end

	self.btnBagAdd = UIControls.Button(self, "TabFunPanel/BtnBagAdd", "Text")

	self.btnBagAdd:addEventClick(self.onBtnBagClick)

	self.btnFilter = UIControls.Button(self, "TabFunPanel/BtnFilter", "Text")

	self.btnFilter:addEventClick(self.onBtnSuitFilterClick)

	self.btnRecycle = UIControls.Button(self, "TabFunPanel/BtnRecycle")

	self.btnRecycle:addEventClick(self.onBtnRecycleClick)

	self.iconNewRecycle = UIControls.RedDot(self, "TabFunPanel/BtnRecycle/IconNew")

	self.iconNewRecycle:addHint({
		UIConst.RD_HINT_EQUIP_RECYCLE_AWARD
	})
	self.btnBagAdd:setText(CurAvatar:getEquipCount() .. "/" .. CurAvatar:getBagSize(Const.BAG_TYPE_EQUIP))

	self.btnSell = UIControls.Button(self, "TabFunPanel/BtnSell", "Text")

	self.btnSell:addEventClick(self.onBtnSellClick)

	self.panelItemSell = UIControls.Panel(self, "ItemSellPanel")
	self.btnChoose = UIControls.Button(self, "ItemSellPanel/BtnChoose")

	self.btnChoose:addEventClick(self.onBtnChooseClick)

	self.btnSellConfirm = UIControls.Button(self, "ItemSellPanel/BtnSell", "TextNum")

	self.btnSellConfirm:addEventClick(self.onSellConfirmClick)

	self.txtSellGold = UIControls.Label(self, "ItemSellPanel/IconGold/TextNum")
	self.sortPanel = CommonSortPanel(self, "TabFunPanel")
	self.sortPanel.mEventDataListChanged = Slot(self.updateSort, self)

	self.sortPanel:initSortInfo(EQUIP_SORT_MAP)

	self.filterConfig = ClientUtils.getFilterConfig({
		{
			1,
			2
		},
		{
			1,
			2
		}
	})
	self.suitFilterMap = CurAvatar:initSuitFilterMapInfo()
end

function BagEquipPart:onBtnSuitFilterClick()
	local siftBoxDlg = UIManager.getUI("siftBoxDlg", true)

	if siftBoxDlg then
		siftBoxDlg:setIsHaveAll(true)
		siftBoxDlg:initFilterInfo(self.suitFilterMap, self.filterSuitConfig, Slot(self.filterSuitCallBack, self))
		siftBoxDlg:setTitle(Lang.get(50274))
	end
end

function BagEquipPart:onBtnRecycleClick()
	local actData = CurAvatar:getEquipRecycleActivityData()

	if actData then
		UIManager.getUI("activityEquipRecycleDlg", true):setData(actData)
	end
end

function BagEquipPart:refreshEquipRecycle(...)
	local actData = CurAvatar:getEquipRecycleActivityData()

	if actData and not actData:checkOpenRecycleSystem() and self.btnBagAdd:getVisible() then
		self.btnRecycle:setVisible(true)
	else
		self.btnRecycle:setVisible(false)
	end
end

function BagEquipPart:onSellConfirmClick()
	if self.sellEquipList and #self.sellEquipList > 0 then
		local function yesFunc()
			if #self.sellEquipList > ONCE_SELL_MAX then
				local rpcCount = math.ceil(#self.sellEquipList / ONCE_SELL_MAX)
				local rpcTable = {}

				for idx = 1, rpcCount do
					local equipSellPack = {}
					local startIdx = (idx - 1) * ONCE_SELL_MAX + 1
					local endIdx = idx * ONCE_SELL_MAX

					for equipIdx = startIdx, endIdx do
						table.insert(equipSellPack, self.sellEquipList[equipIdx])
					end

					rpcTable[idx] = equipSellPack
				end

				for _, data in ipairs(rpcTable) do
					RPC.equipSell(data)
				end
			else
				RPC.equipSell(self.sellEquipList)
			end
		end

		local sellGold = 0

		for _, gid in ipairs(self.sellEquipList) do
			local equipGold = CurAvatar.bagEquips[gid].resData.sell[1].num

			sellGold = sellGold + equipGold
		end

		local msgContent = Lang.get(1837)

		if ResItemSpecialConfig and ResItemSpecialConfig[Const.MONEY_ID_GOLD] then
			local priceStr = sellGold .. (ResItemSpecialConfig[Const.MONEY_ID_GOLD].emoji_path or "")

			msgContent = string.format(ClientUtils.getClientNotice(432), priceStr)
		end

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
	else
		MsgManager.notice(Lang.get(30463))
	end
end

function BagEquipPart:onBtnChooseClick()
	local siftBoxDlg = UIManager.getUI("siftBoxDlg", true)

	if siftBoxDlg then
		siftBoxDlg:initFilterInfo(EQUIP_SELL_FILTER_MAP, self.filterConfig, Slot(self.filterCallBack, self))
		siftBoxDlg:setTitle(Lang.get(30464))
	end
end

function BagEquipPart:onBtnSellClick()
	self.panelItemSell:changeVisible()
	self.btnBagAdd:setVisible(not self.panelItemSell:getVisible())
	self:refreshEquipRecycle()

	local btnText = self.panelItemSell:getVisible() and Lang.get(7) or Lang.get(528)

	self.btnSell:setText(btnText)

	if not self.panelItemSell:getVisible() then
		self:clearSellEquipList()
	end

	self:refreshItemSellPanel()
end

function BagEquipPart:onBtnBagClick()
	CurAvatar:openBagGridAddDlg(Const.BAG_TYPE_EQUIP)
end

function BagEquipPart:refreshBagBlankNum()
	self.btnBagAdd:setText(CurAvatar:getEquipCount() .. "/" .. CurAvatar:getBagSize(Const.BAG_TYPE_EQUIP))
end

function BagEquipPart:onClickPart(sender)
	self:_refreshFilter(sender.part)
end

function BagEquipPart:_refreshFilter(filter)
	self.gidGridDic = {}
	self.cellGidDic = {}
	self.filter = filter

	for index, btn in pairs(self.filterPartBtns) do
		btn:setEnable(filter ~= index)
	end

	self:onPartClose()
	self:refreshData()
end

function BagEquipPart:refreshData()
	if not CurAvatar then
		return
	end

	if self.panelItemSell:getVisible() then
		self:onBtnSellClick()
	end

	self.items = CurAvatar:getAllEquips(self.filter, true)

	if self.checkFilterSuitFunc then
		local tmpItems = {}

		for _, equip in ipairs(self.items) do
			if self.checkFilterSuitFunc(equip) then
				table.insert(tmpItems, equip)
			end
		end

		self.sortPanel:sortByCurConfig(tmpItems)
	else
		self.sortPanel:sortByCurConfig(self.items)
	end

	self:refreshBagBlankNum()
	self:refreshEquipRecycle()
end

function BagEquipPart:updateSort(items)
	self.items = items

	self:updateScroll()
end

function BagEquipPart:updateScroll()
	if #self.items == 0 then
		self.imgNone:setVisible(true)
		self.scroll:setVisible(false)
	else
		self.imgNone:setVisible(false)
		self.sortPanel:setVisible(true)
		self.scroll:setVisible(true)
		self.scroll:setTotalCount(#self.items)
	end
end

function BagEquipPart:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.EquipGridLoop(sender, "System/Common/Grid/GridEquipItem", newIdx)
		targetCell.mTipsConfig = CurAvatar.commonEquipTipsFuncItem

		targetCell.btnSensor:clearEventClick()
		targetCell.btnSensor:addEventClick(Slot(self.onGridClickOrSel, self))

		targetCell.inBag = true
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setObj(self.items[newIdx])
	targetCell.imgSelect:setVisible(self:checkIsBeSelect(targetCell.object.gid))

	self.cellGidDic[targetCell] = self.items[newIdx].gid
	self.gidGridDic[self.items[newIdx].gid] = targetCell
end

function BagEquipPart:onGridClickOrSel(sender, btn)
	if self.panelItemSell:getVisible() then
		self:equipSellSelct(btn.mParent.object.gid, not btn.mParent.imgSelect:getVisible())
	else
		btn.mParent:onGridClick(btn)
	end
end

function BagEquipPart:equipSellSelct(gid, isSelect)
	if not self.sellEquipList then
		self.sellEquipList = {}
	end

	if CurAvatar.bagEquips[gid].inWearing then
		MsgManager.notice(Lang.get(30465))

		return
	end

	if CurAvatar.bagEquips[gid].isLock and CurAvatar.bagEquips[gid].isLock == 1 then
		MsgManager.notice(Lang.get(96570))

		return
	end

	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_EQUIP_REFINE)

	if actObj and actObj:isValid() and actObj.actData:isEquipReform(gid) then
		MsgManager.notice(Lang.get(91262))

		return
	end

	if isSelect then
		table.insert(self.sellEquipList, gid)
	else
		for idx, selGid in ipairs(self.sellEquipList) do
			if selGid == gid then
				table.remove(self.sellEquipList, idx)

				break
			end
		end
	end

	if self.gidGridDic[gid] then
		self.gidGridDic[gid].imgSelect:setVisible(isSelect)
	end

	self:refreshItemSellPanel()
end

function BagEquipPart:checkIsBeSelect(gid)
	if self.sellEquipList then
		for idx, selGid in ipairs(self.sellEquipList) do
			if selGid == gid then
				return true
			end
		end

		return false
	end

	return false
end

function BagEquipPart:refreshItemSellPanel()
	if not self.sellEquipList then
		self.sellEquipList = {}
	end

	self.btnSellConfirm:setText("(" .. #self.sellEquipList .. ")")

	local sellGold = 0

	for _, gid in ipairs(self.sellEquipList) do
		local equipGold = CurAvatar.bagEquips[gid].resData.sell[1].num

		sellGold = sellGold + equipGold
	end

	self.txtSellGold:setText(sellGold)
end

function BagEquipPart:clearSellEquipList()
	if self.sellEquipList then
		for idx = #self.sellEquipList, 1, -1 do
			if self.gidGridDic[self.sellEquipList[idx]] then
				self.gidGridDic[self.sellEquipList[idx]].imgSelect:setVisible(false)
			else
				for _, equipGrid in pairs(self.cells) do
					if equipGrid.object.gid == self.sellEquipList[idx] then
						equipGrid.imgSelect:setVisible(false)
					end
				end
			end

			table.remove(self.sellEquipList, idx)
		end

		self:refreshItemSellPanel()

		self.gidGridDic = {}
		self.cellGidDic = {}

		self.scroll:setTotalCount(#self.items)
	end
end

function BagEquipPart:filterCallBack(checkFilterFunc, _filterConfig)
	self.checkFilterFunc = checkFilterFunc
	self.filterConfig = _filterConfig

	self:clearSellEquipList()

	if self.checkFilterFunc then
		for _, equip in ipairs(self.items) do
			if self.checkFilterFunc(equip) and not equip.inWearing then
				self:equipSellSelct(equip.gid, true)
			end
		end
	end

	local siftBoxDlg = UIManager.getUI("siftBoxDlg", nil, false)

	if siftBoxDlg then
		siftBoxDlg:setVisible(false)
	end
end

function BagEquipPart:filterSuitCallBack(filterSuitCheckFunc, _filterSuitConfig)
	self.checkFilterSuitFunc = filterSuitCheckFunc
	self.filterSuitConfig = _filterSuitConfig

	local tmpItems = {}
	local allItems = CurAvatar:getAllEquips(self.filter, true)

	if self.checkFilterSuitFunc then
		for _, equip in ipairs(allItems) do
			if self.checkFilterSuitFunc(equip) then
				table.insert(tmpItems, equip)
			end
		end
	end

	self.sortPanel:sortByCurConfig(tmpItems)

	if self.imgNone then
		self.imgNone:setVisible(#tmpItems == 0)
	end

	local siftBoxDlg = UIManager.getUI("siftBoxDlg", nil, false)

	if siftBoxDlg then
		siftBoxDlg:setVisible(false)
	end
end

function BagEquipPart:onPartClose()
	self.checkFilterFunc = nil
	self.filterConfig = ClientUtils.getFilterConfig({
		{
			1,
			2
		},
		{
			1,
			2
		}
	})
	self.sellEquipList = nil
end

return BagEquipPart
