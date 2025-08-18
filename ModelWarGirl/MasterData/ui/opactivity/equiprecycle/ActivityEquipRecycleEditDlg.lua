-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\EquipRecycle\\ActivityEquipRecycleEditDlg.lua

local CommonEquipListPanel = require("UI/Battle/CommonEquipListPanel")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local GridEquipRecycleEquipContainer = require("UI/OpActivity/EquipRecycle/GridEquipRecycleEquipContainer")
local ActivityEquipRecycleRewardCell = Class("ActivityEquipRecycleRewardCell", UIControls.Child)

function ActivityEquipRecycleRewardCell:ctor(...)
	self:initUI()
end

function ActivityEquipRecycleRewardCell:initUI(...)
	self.txtNum = UIControls.Label(self, "NumPanel/TxtNum")
	self.panelEquip = UIControls.Panel(self, "GridEquipItem")

	self.panelEquip:setVisible(true)

	self.awardCells = {}
	self.gridEquip = UIControls.EquipGridChild(self, "GridEquipItem", "System/Common/Grid/GridEquipItem", 0, 0, true)
end

function ActivityEquipRecycleRewardCell:setData(data)
	self.txtNum:setText(self.index)

	self.data = data

	if self.data then
		if self.index == 1 and self.mParent.listData and self.mParent.listData.startTime ~= 0 then
			self:playStateAnimator("Cell1Recycle")
		else
			self:playStateAnimator("Cell1Full")
		end

		self.gridEquip:setObj(self.data)

		local showIds, showNums = CurAvatar:getEquipRecycleReturn(self.data, 1)

		for index = 1, #showIds do
			if not self.awardCells[index] then
				self.awardCells[index] = UIControls.getGridAwardContainer(self, "GridRewardList/Content")
				self.awardCells[index].mDisableWays = true
			end

			local item = BaseObject.GetObject(showIds[index], showNums[index])

			self.awardCells[index]:setVisible(true)
			self.awardCells[index]:setObj(item)
			self.awardCells[index]:hideTxtNum(true)
		end

		local num = #showIds

		for index = num + 1, #self.awardCells do
			self.awardCells[index]:setVisible(false)
		end
	else
		self:playStateAnimator("Cell1Empty")
	end
end

local ActivityEquipRecycleEditDlg = Class("ActivityEquipRecycleEditDlg", UIControls.Window)

function ActivityEquipRecycleEditDlg:ctor(...)
	self:initUI()
end

function ActivityEquipRecycleEditDlg:initUI(...)
	self.content = UIControls.Panel(self, "MainInfoPanel/RewardPanel/Bg/RewardList/Content")
	self.tipsCostTime = UIControls.Label(self, "MainInfoPanel/RewardPanel/Bg/Tips2")
	self.btnStart = UIControls.Button(self, "MainInfoPanel/RewardPanel/Bg/BtnStart")

	self.btnStart:addEventClick(self.onBtnStartClick)

	self.noContent = UIControls.Panel(self, "MainInfoPanel/BgItemList/EquipListPanel/NoContent")
	self.filterSelectPanel = FilterSelectPanel(self, "MainInfoPanel/BgItemList/ListSelectPanel")
	self.listEquips = CommonEquipListPanel(self, "MainInfoPanel/BgItemList")
	self.listEquips.isDragTip = false
	self.listEquips._slot4CellSelect = Slot(self.onEquipCellClick, self)
	self.rewardCells = {}
	self.btnFilter = UIControls.Button(self, "MainInfoPanel/BgItemList/TabFunPanel/BtnFilter")

	self.btnFilter:addEventClick(self.onBtnFilterClick)

	for index = 1, 6 do
		self.rewardCells[index] = ActivityEquipRecycleRewardCell(self, "MainInfoPanel/RewardPanel/Bg/RewardList/Content", "System/Activity/ActivityEquipRecycle/EquipRecycleRewardCell1")
		self.rewardCells[index].index = index

		self.rewardCells[index]:setVisible(true)
	end

	self.suitFilterMap = CurAvatar:initSuitFilterMapInfo()
end

function ActivityEquipRecycleEditDlg:setListIndex(index)
	self.listIndex = index
	self.isRent = self.listIndex == Const.EQUIP_RECYCLE_LIST_RENT
end

function ActivityEquipRecycleEditDlg:setData(actData)
	self.actData = actData or self.actData

	if self.actData then
		local costTime = 0

		if self.isRent then
			costTime = self.actData:getRentListUnitTime()
		else
			costTime = self.actData:getNormarListUnitTime()
		end

		local costHour = costTime / 3600

		self.tipsCostTime:setText(utils.format(Lang.get(101570), costHour))

		self.allEquips = self.actData:getAllCanRecycleEquipList(self.listIndex)

		local showEquips = {}

		if self.checkFilterSuitFunc then
			for _, equip in ipairs(self.allEquips) do
				if self.checkFilterSuitFunc(equip) then
					table.insert(showEquips, equip)
				end
			end
		else
			showEquips = self.allEquips
		end

		if not self.listEquips.cellClass then
			self.listEquips:initEquipList(GridEquipRecycleEquipContainer, "System/Activity/ActivityEquipRecycle/GridEquipRecycleContainer2", UIConst.EQUIP_DEFAULT_SORT_MAP, UIConst.HERO_DEFAULT_FILTER_PANEL_MAP, showEquips)
		else
			self.listEquips:updateEquipBag(showEquips)
			self.listEquips:refreshSort()
		end

		if self.listIndex == 1 then
			self.listData = self.actData.mainWorkShopData
		else
			self.listData = self.actData.rentWorkShopData
		end

		for index = 1, 6 do
			local Equip

			Equip = self.listData.equipList[index]
			self.rewardCells[index].index = index

			self.rewardCells[index]:setData(Equip)
		end
	end
end

function ActivityEquipRecycleEditDlg:onEquipCellClick(sender)
	local equip = sender.equip

	if equip then
		if equip.inOtherList then
			MsgManager.notice(Lang.get(101571))
		elseif equip.recycleIndex == 1 and equip.listStarted then
			local function funY(self)
				RPC.opActEquipRecycleStop(self.actData.actObject.opId, self.listIndex)
			end

			UIManager.showConfirmWithId(1131, Slot(funY, self), nil)
		else
			self:handleEquipToServer(equip)
		end
	end
end

function ActivityEquipRecycleEditDlg:handleEquipToServer(equip)
	if equip then
		if not equip.recycleListIndex or equip.recycleListIndex == 0 then
			local num = 0

			if self.listData.equipList then
				num = #self.listData.equipList
			end

			if num >= 6 then
				MsgManager.notice(Lang.get(101572))

				return
			end
		end

		local op_type = "kEquipRecycleOpTypeAdd"

		for index, Equip in ipairs(self.listData.equipList or {}) do
			if equip.gid == Equip.gid then
				op_type = "kEquipRecycleOpTypeDelete"
			end
		end

		RPC.opActEquipRecycleChoose(self.actData.actObject.opId, op_type, tostring(equip.gid), self.listIndex)
	end
end

function ActivityEquipRecycleEditDlg:onBtnFilterClick()
	local siftBoxDlg = UIManager.getUI("equipRecycleSiftBoxDlg", true)

	if siftBoxDlg then
		siftBoxDlg:setIsHaveAll(true)
		siftBoxDlg:initFilterInfo(self.suitFilterMap, self.filterSuitConfig, Slot(self.filterSuitCallBack, self))
		siftBoxDlg:setTitle(Lang.get(50274))
	end
end

function ActivityEquipRecycleEditDlg:filterSuitCallBack(filterSuitCheckFunc, _filterSuitConfig)
	self.checkFilterSuitFunc = filterSuitCheckFunc
	self.filterSuitConfig = _filterSuitConfig

	local tmpItems = {}

	if self.checkFilterSuitFunc then
		for _, equip in ipairs(self.allEquips) do
			if self.checkFilterSuitFunc(equip) then
				table.insert(tmpItems, equip)
			end
		end
	end

	self.listEquips:updateEquipBag(tmpItems)
	self.listEquips:refreshSort()

	local siftBoxDlg = UIManager.getUI("equipRecycleSiftBoxDlg", nil, false)

	if siftBoxDlg then
		siftBoxDlg:setVisible(false)
	end
end

function ActivityEquipRecycleEditDlg:onBtnStartClick()
	self:setVisible(false)
end

return ActivityEquipRecycleEditDlg
