-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivitySeasonTowerBuffAllDlg.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResOpActTowerBuff = require("ClientData/ResOpActTowerBuff")
local strClassName = "ActivitySeasonTowerBuffAllDlg"
local ActivitySeasonTowerBuffAllDlg = Class(strClassName, UIControls.Window)

function ActivitySeasonTowerBuffAllDlg:ctor()
	self:initUI()
end

function ActivitySeasonTowerBuffAllDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickClose)

	self.buffCells = {}
	self.textTitle = UIControls.Label(self, "BgPanel/TextTitle")
end

function ActivitySeasonTowerBuffAllDlg:onShow(buffs, towerName, newBuffs)
	for index = #self.buffCells, #buffs - 1 do
		local newCell = UIControls.GridBuffWithMaster(self, "BgPanel/GridPanel/Content", "System/Common/Grid/GridBuff")

		table.insert(self.buffCells, newCell)
	end

	newBuffs = newBuffs or {}

	local newIndex = #newBuffs

	for index, buff in ipairs(buffs) do
		local buffId = buff[3]

		if newBuffs then
			local has = false

			for _, nBuff in ipairs(newBuffs) do
				if nBuff[3] == buffId then
					has = true

					break
				end
			end

			if not has then
				table.insert(newBuffs, buff)
			end
		else
			table.insert(newBuffs, buff)
		end
	end

	for index, cell in ipairs(self.buffCells) do
		if newBuffs[index] then
			cell:setVisible(true)

			local buffId = newBuffs[index][3]
			local master = newBuffs[index][2]

			cell:initBuffData(ResOpActTowerBuff[buffId], master, index <= newIndex)
		else
			cell:setVisible(false)
		end
	end

	self.textTitle:setText(string.format(Lang.get(30634), towerName))
end

function ActivitySeasonTowerBuffAllDlg:onClickClose()
	self:setVisible(false)
end

return ActivitySeasonTowerBuffAllDlg
