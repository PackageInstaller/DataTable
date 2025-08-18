-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetDegreeLevelAwardDlg.lua

local ResPetDegreeLevel = require("ClientData/ResPetDegreeLevel")
local strClassName = "DegreeLevelCell"
local DegreeLevelCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function DegreeLevelCell:ctor()
	self:initUI()
end

function DegreeLevelCell:initUI()
	self.txtTitle = UIControls.Label(self, "TxtTitle")
	self.items = {}
end

function DegreeLevelCell:setData(data)
	self.data = data

	if Const.REVIEW_VERSION then
		self.txtTitle:setText(string.format(Lang.get(111361), self.data.level))
	else
		self.txtTitle:setText(string.format("Lv.%d", self.data.level))
	end

	ClientUtils.CreateBonusGrid(self, self.items, "GridPanel", self.data.award_id, true, nil, true)

	if self.data.level <= CurAvatar.petDegreeLevel then
		for index, grid in ipairs(self.items) do
			grid:setGet(true)
		end
	end
end

local strClassName = "PetDegreeLevelAwardDlg"
local PetDegreeLevelAwardDlg = Class(strClassName, UIControls.Window)

function PetDegreeLevelAwardDlg:ctor()
	self:initUI()
end

function PetDegreeLevelAwardDlg:initUI()
	self.txtNum = UIControls.Label(self, "BgPanel/LevelPanel/TxtNum")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.cellListPanel = UIControls.ScrollViewLoopV(self, "BgPanel/CellListPanel")

	self.cellListPanel:addEventCellChanged(self.onCellChanged)

	self.Cells = {}
end

function PetDegreeLevelAwardDlg:setData()
	self.datas = {}

	for i, v in ipairs(ResPetDegreeLevel) do
		if v.award_id then
			table.insert(self.datas, v)
		end
	end

	local idx = 0

	for i, v in ipairs(self.datas) do
		if idx == 0 and v.level >= CurAvatar.petDegreeLevel then
			idx = i
		end
	end

	self.cellListPanel:setTotalCount(#self.datas, math.min(idx, #self.datas))
	self.txtNum:setText(CurAvatar.petDegreeLevel)
end

function PetDegreeLevelAwardDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = DegreeLevelCell(sender, "System/Pet/FasionLevelCell", newIdx)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:setData(self.datas[newIdx])
end

function PetDegreeLevelAwardDlg:onBtnCloseClick()
	self:setVisible(false)
end

return PetDegreeLevelAwardDlg
