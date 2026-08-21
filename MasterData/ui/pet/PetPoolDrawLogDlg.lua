-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPoolDrawLogDlg.lua

local ResPetGashaponConfig = require("ClientData/ResPetGashaponConfig")
local ResPetGashaponDraw = require("ClientData/ResPetGashaponDraw")
local PoolDrawLogCell = require("UI/Pet/PoolDrawLogCell")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local PAGE_NUM = 5
local strClassName = "PetPoolDrawLogDlg"
local PetPoolDrawLogDlg = Class(strClassName, UIControls.Window)

function PetPoolDrawLogDlg:ctor()
	self:initUI()
end

function PetPoolDrawLogDlg:initUI()
	self.probabilityPanel = UIControls.Panel(self, "BgPanel/ProbabilityInfo")
	self.emptyPanel = UIControls.Panel(self, "BgPanel/EmptyPanel")
	self.drawLogScroll = UIControls.ScrollViewLoopV(self, "BgPanel/ProbabilityInfo/DrawLogListPanel")

	self.drawLogScroll:addEventCellChanged(self.onCellChanged)

	self.cells = {}
	self.btnPre = UIControls.Button(self, "BgPanel/BtnPre")

	self.btnPre:addEventClick(self.onBtnPreClick)

	self.btnNext = UIControls.Button(self, "BgPanel/BtnNext")

	self.btnNext:addEventClick(self.onBtnNextClick)

	self.textPage = UIControls.Label(self, "BgPanel/BgTextPage/TextPage")
	self.textRule = UIControls.Label(self, "BgPanel/BgTextRule/TextRule")
end

function PetPoolDrawLogDlg:setData(poolId)
	self.poolId = poolId
	self.page = 1

	DrawCardUtils.syncDrawRecord(self.poolId)

	local record = DrawCardUtils.getDrawRecord(self.poolId)

	self:setRecordData(record)
end

function PetPoolDrawLogDlg:setRecordData(recordList)
	self.recordList = recordList

	self:refreshRecordData()
end

function PetPoolDrawLogDlg:refreshRecordData()
	self.maxPage = math.ceil(#self.recordList / PAGE_NUM)
	self.nowRecordList = {}

	if self.page <= self.maxPage then
		for i = (self.page - 1) * PAGE_NUM + 1, self.page * PAGE_NUM do
			if self.recordList[i] then
				table.insert(self.nowRecordList, self.recordList[i])
			end
		end
	end

	if #self.nowRecordList > 0 then
		self.probabilityPanel:setVisible(true)
		self.emptyPanel:setVisible(false)
		self.drawLogScroll:setTotalCount(#self.nowRecordList)
	else
		self.probabilityPanel:setVisible(false)
		self.emptyPanel:setVisible(true)
	end

	self.textPage:setText(string.format(Lang.get(78794), self.page))
	self.btnPre:setVisible(self.page > 1)
	self.btnNext:setVisible(self.page < self.maxPage)
end

function PetPoolDrawLogDlg:onCellChanged(sender, targetCell, newIdx)
	targetCell = targetCell or PoolDrawLogCell(sender, "System/PetPool/PetPoolDrawLogCell", newIdx)

	if not self.nowRecordList or #self.nowRecordList == 0 then
		return
	end

	if self.nowRecordList[newIdx] ~= nil then
		targetCell:setData(self.nowRecordList[newIdx])
	end

	self.cells[newIdx] = targetCell
end

function PetPoolDrawLogDlg:onBtnPreClick()
	if self.page > 1 then
		self.page = self.page - 1
	end

	self:refreshRecordData()
end

function PetPoolDrawLogDlg:onBtnNextClick()
	if self.maxPage > self.page then
		self.page = self.page + 1
	end

	self:refreshRecordData()
end

return PetPoolDrawLogDlg
