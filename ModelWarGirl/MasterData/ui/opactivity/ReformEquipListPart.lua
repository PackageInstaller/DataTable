-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ReformEquipListPart.lua

local strClassName = "ReformEquipListPart"
local ReformEquipListPart = Class(strClassName, UIControls.Panel)
local FILTER_ALL = 0
local MAX_EQUIP_PART = 6

function ReformEquipListPart:ctor()
	self:initUI()
end

function ReformEquipListPart:initUI()
	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, self.mPath .. "/EquipNode/EquipList")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.imgNone = UIControls.Image(self, self.mPath .. "/EquipNode/BgNothing")
	self.btnFilterAll = UIControls.Button(self, self.mPath .. "/EquipNode/ListSelectPanel/BtnAll")
	self.btnFilterAll.part = FILTER_ALL

	self.btnFilterAll:addEventClick(self.onClickPart)

	self.filterPartBtns = {}
	self.filterPartBtns[FILTER_ALL] = self.btnFilterAll

	for index = 1, MAX_EQUIP_PART do
		local newBtn = UIControls.Button(self, self.mPath .. "/EquipNode/ListSelectPanel/Btn" .. index - 1)

		newBtn.part = index

		newBtn:addEventClick(self.onClickPart)
		table.insert(self.filterPartBtns, newBtn)
	end

	self.filter = FILTER_ALL

	for index, btn in pairs(self.filterPartBtns) do
		btn:setEnable(self.filter ~= index)
	end

	self.btnFilter = UIControls.Button(self, self.mPath .. "/EquipNode/BtnFilter", "Text")

	self.btnFilter:addEventClick(self.onBtnSuitFilterClick)

	self.suitFilterMap = CurAvatar:initSuitFilterMapInfo()
	self.btnStar = UIControls.Button(self, self.mPath .. "/EquipNode/BtnStar")

	self.btnStar:addEventClick(self.onBtnStarClick)
end

function ReformEquipListPart:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.EquipGridLoop(sender, "System/Common/Grid/GridEquipItem", newIdx)

		targetCell.btnSensor:clearEventClick()
		targetCell.btnSensor:addEventClick(Slot(self.onGridClickOrSel, self))

		targetCell.inBag = true
	else
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setObj(self.items[newIdx])
	targetCell.imgSelect:setVisible(self.curChooseGid and self.curChooseGid == targetCell.object.gid)
end

function ReformEquipListPart:onGridClickOrSel(sender, btn)
	for idx, cell in pairs(self.cells) do
		cell.imgSelect:setVisible(btn.mParent.object.gid == cell.object.gid)
	end

	self.curChooseGid = btn.mParent.object.gid

	if self.mEventChoose then
		self.mEventChoose(self)
	end
end

function ReformEquipListPart:onClickPart(sender)
	self:_refreshFilter(sender.part)
end

function ReformEquipListPart:_refreshFilter(filter)
	self.filter = filter

	for index, btn in pairs(self.filterPartBtns) do
		btn:setEnable(filter ~= index)
	end

	self:refreshData()
end

function ReformEquipListPart:refreshData()
	if not CurAvatar then
		return
	end

	self.items = CurAvatar:getCanReformEquips(self.filter)

	if self.checkFilterSuitFunc then
		local tmpItems = {}

		for _, equip in ipairs(self.items) do
			if self.checkFilterSuitFunc(equip) then
				table.insert(tmpItems, equip)
			end
		end

		self.items = tmpItems
	end

	self:updateScroll()
end

function ReformEquipListPart:updateScroll()
	if #self.items == 0 then
		self.imgNone:setVisible(true)
		self.scroll:setVisible(false)
	else
		self.imgNone:setVisible(false)
		self.scroll:setVisible(true)
		self.scroll:setTotalCount(#self.items)
	end
end

function ReformEquipListPart:onBtnSuitFilterClick()
	local siftBoxDlg = UIManager.getUI("siftBoxDlg", true)

	if siftBoxDlg then
		siftBoxDlg:setIsHaveAll(true)
		siftBoxDlg:initFilterInfo(self.suitFilterMap, self.filterSuitConfig, Slot(self.filterSuitCallBack, self))
		siftBoxDlg:setTitle(Lang.get(50274))
	end
end

function ReformEquipListPart:filterSuitCallBack(filterSuitCheckFunc, _filterSuitConfig)
	self.checkFilterSuitFunc = filterSuitCheckFunc
	self.filterSuitConfig = _filterSuitConfig

	self:refreshData()

	local siftBoxDlg = UIManager.getUI("siftBoxDlg", nil, false)

	if siftBoxDlg then
		siftBoxDlg:setVisible(false)
	end
end

function ReformEquipListPart:setConfirmCallBack(mEventComfirm)
	self.mEventComfirm = mEventComfirm
end

function ReformEquipListPart:setChooseCallBack(mEventChoose)
	self.mEventChoose = mEventChoose
end

function ReformEquipListPart:onBtnStarClick()
	if self.mEventComfirm then
		self.mEventComfirm(self)
	end
end

return ReformEquipListPart
