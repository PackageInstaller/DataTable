-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseMoreRoomPanel.lua

local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local BtnRoomCell = Class("BtnRoomCell", UIControls.Child)

function BtnRoomCell:ctor(...)
	self:initUI()
end

function BtnRoomCell:initUI(...)
	self.txtNum = UIControls.Label(self, "BgNum/TextNum")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	if UIControls.checkControlFunc(self, "ImgMainRoom") then
		self.imgMainRoom = UIControls.Panel(self, "ImgMainRoom")
	end
end

function BtnRoomCell:setData(idx)
	self.idx = idx

	if not self.mParent.isVisit and not self.redNew then
		self.redNew = UIControls.RedDot(self, "IconNew")

		self.redNew:addHint({
			UIConst["RD_HINT_REAR_HOUSE_EDIT" .. idx]
		})
	end

	if idx == 1 then
		self.rdRearHouseCrystalNew = UIControls.RedDot(self, "IconNewCat")

		self.rdRearHouseCrystalNew:addHint({
			UIConst.RD_HINT_REAR_HOUSE_CRYSTLE
		})
	end

	self.txtNum:setText(idx)
	self:refreshData()
end

function BtnRoomCell:refreshData(...)
	self.isUnlock = RearHouseCommon.isRoomUnlock(self.idx, self.mParent.houseData.level)

	self:setVisible(self.isUnlock)

	if self.imgMainRoom then
		if not self.mParent.isVisit then
			self.imgMainRoom:setVisible(CurAvatar.mainRoom and CurAvatar.mainRoom == self.idx)
		else
			self.imgMainRoom:setVisible(self.mParent.houseData.main_room and self.mParent.houseData.main_room == self.idx)
		end
	end
end

function BtnRoomCell:onBtnSensorClick(...)
	if not self.isUnlock then
		MsgManager.notice(Lang.get(54314))

		return
	end

	if RearHouseDragCenter.getCurZoneId() == self.idx then
		MsgManager.notice(Lang.get(54315))

		return
	end

	self.mWindow.panelRoom:setVisible(false)

	local state = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

	if state then
		state:changeWall(self.idx, true)
	end

	if not self.mParent.isVisit then
		self.mWindow:checkEditRedHint()
	end
end

local RearHouseMoreRoomPanel = Class("RearHouseMoreRoomPanel", UIControls.Panel)

function RearHouseMoreRoomPanel:ctor(...)
	self:initUI()
end

function RearHouseMoreRoomPanel:initUI(...)
	self.btnThrough = UIControls.Button(self, self.mPath .. "/UIClickThrough")

	self.btnThrough:addEventClick(self.onBtnThroughClick)

	self.cells = {}
end

function RearHouseMoreRoomPanel:setData(isVisit)
	self.houseData = RearHouseDragCenter.getCurShowData()
	self.isVisit = isVisit

	for i = 1, Const.REARHOUSE_WALL_NUM do
		local cell = self.cells[i]

		if not cell then
			cell = BtnRoomCell(self, self.mPath, "System/Backyard/BtnRoom", 0, 0, true)

			table.insert(self.cells, cell)
		end

		cell:setData(i)
	end
end

function RearHouseMoreRoomPanel:refreshData(...)
	for i, cell in ipairs(self.cells) do
		cell:refreshData()
	end
end

function RearHouseMoreRoomPanel:onBtnThroughClick(...)
	self.mWindow.panelRoom:setVisible(false)
end

return RearHouseMoreRoomPanel
