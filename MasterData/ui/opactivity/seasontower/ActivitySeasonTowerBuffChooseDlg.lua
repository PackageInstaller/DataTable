-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivitySeasonTowerBuffChooseDlg.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResOpActTowerBuff = require("ClientData/ResOpActTowerBuff")
local strClassName = "ActivitySeasonTowerBuffChooseDlg"
local ActivitySeasonTowerBuffChooseDlg = Class(strClassName, UIControls.Window)

function ActivitySeasonTowerBuffChooseDlg:ctor()
	self:initUI()
end

function ActivitySeasonTowerBuffChooseDlg:initUI()
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickConfirm)

	self.btnHoldOn = UIControls.Button(self, "BgPanel/BtnHoldOn")

	self.btnHoldOn:addEventClick(self.onClickHoldOn)

	self.buffCells = {}
end

function ActivitySeasonTowerBuffChooseDlg:onShow(stageData, opId)
	local buffs = stageData.buff

	self.opId = opId
	self.towerId = stageData.tower_id
	self.layer = stageData.layer

	for index = #self.buffCells, #buffs - 1 do
		local newCell = UIControls.BuffGridChild(self, "BgPanel/BuffPanel", "System/Common/Grid/GridBuff")

		newCell.mEventClick = Slot(self.onChooseClick, self)

		table.insert(self.buffCells, newCell)
	end

	for index, cell in ipairs(self.buffCells) do
		if buffs[index] then
			cell:setVisible(true)
			cell:setBuff(ResOpActTowerBuff[buffs[index].id])
		else
			cell:setVisible(false)
		end
	end

	self.curChoose = nil
end

function ActivitySeasonTowerBuffChooseDlg:onChooseClick(sender)
	for index, cell in ipairs(self.buffCells) do
		cell:setSelected(sender == cell)
	end

	self.curChoose = sender.buffId
end

function ActivitySeasonTowerBuffChooseDlg:onClickConfirm()
	if self.curChoose then
		RPC.opActTowerSetBuff(self.opId, self.towerId, self.layer, self.curChoose)
		self:setVisible(false)
	else
		MsgManager.clientNotice(342)
	end
end

function ActivitySeasonTowerBuffChooseDlg:onClickHoldOn()
	self:setVisible(false)
end

return ActivitySeasonTowerBuffChooseDlg
