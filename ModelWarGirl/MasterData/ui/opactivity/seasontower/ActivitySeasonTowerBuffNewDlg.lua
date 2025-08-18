-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivitySeasonTowerBuffNewDlg.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResOpActTowerBuff = require("ClientData/ResOpActTowerBuff")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local strClassName = "ActivitySeasonTowerBuffNewDlg"
local ActivitySeasonTowerBuffNewDlg = Class(strClassName, UIControls.Window)

function ActivitySeasonTowerBuffNewDlg:ctor()
	self:initUI()
end

function ActivitySeasonTowerBuffNewDlg:initUI()
	self.buffCells = {}
end

function ActivitySeasonTowerBuffNewDlg:onShow(buffs, actData, towerId)
	self.actData = actData
	self.towerId = towerId

	for index = #self.buffCells, #buffs - 1 do
		local newCell = UIControls.GridBuffWithMaster(self, "Bg/GridPanel/Content", "System/Common/Grid/GridBuff")

		table.insert(self.buffCells, newCell)
	end

	for index, cell in ipairs(self.buffCells) do
		if buffs[index] then
			cell:setVisible(true)

			local buffId = buffs[index][3]
			local master = buffs[index][2]

			cell:initBuffData(ResOpActTowerBuff[buffId], master)
		else
			cell:setVisible(false)
		end
	end
end

function ActivitySeasonTowerBuffNewDlg:onClose()
	local activitySeasonTowerInfoDlg = UIManager.tryGetUI("activitySeasonTowerInfoDlg")

	if activitySeasonTowerInfoDlg then
		for index, cell in ipairs(self.buffCells) do
			FlyIconUtils.setFlyUItoUI(cell.imgBuff, activitySeasonTowerInfoDlg.btnBuff)
		end
	end

	self.actData:saveTowerBuffNewFly(self.towerId)
	ActivitySeasonTowerBuffNewDlg.super.onClose(self)
end

return ActivitySeasonTowerBuffNewDlg
