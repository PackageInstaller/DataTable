-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\SimpleBuffDlg.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResBattleStateShow = require("ClientData/ResBattleStateShow")
local strClassName = "SimpleBuffDlg"
local SimpleBuffDlg = Class(strClassName, UIControls.Window)

function SimpleBuffDlg:ctor()
	self:initUI()
end

function SimpleBuffDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickClose)

	self.emptyPanel = UIControls.Panel(self, "BgPanel/ImgNothing")
	self.buffCells = {}
end

function SimpleBuffDlg:setData(buffs)
	local buffData = {}

	for _, buffId in ipairs(buffs) do
		if ResBattleStateShow[buffId] then
			table.insert(buffData, ResBattleStateShow[buffId])
		end
	end

	for index = #self.buffCells, #buffData - 1 do
		local newCell = UIControls.BuffGridChild(self, "BgPanel/GridPanel/Content", "System/Common/Grid/GridBuff")

		table.insert(self.buffCells, newCell)
	end

	for index, cell in ipairs(self.buffCells) do
		if buffData[index] then
			cell:setVisible(true)
			cell:setBuff(buffData[index])
		else
			cell:setVisible(false)
		end
	end

	self.emptyPanel:setVisible(#buffData == 0)
end

function SimpleBuffDlg:onClickClose()
	self:setVisible(false)
end

return SimpleBuffDlg
