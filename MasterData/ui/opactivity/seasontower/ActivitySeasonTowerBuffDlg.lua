-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivitySeasonTowerBuffDlg.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResOpActTowerBuff = require("ClientData/ResOpActTowerBuff")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local strClassName = "ActivitySeasonTowerBuffDlg"
local ActivitySeasonTowerBuffDlg = Class(strClassName, UIControls.Window)

function ActivitySeasonTowerBuffDlg:ctor()
	self.grids = {}
	self.panelScore = UIControls.Panel(self, "BgPanel/BgAward/GridSpecialPanel/Icon1")
	self.textScore = UIControls.Label(self, "BgPanel/BgAward/GridSpecialPanel/Icon1/Text")
	self.panelHook = UIControls.Panel(self, "BgPanel/BgAward/GridSpecialPanel/Icon2")
	self.textHook = UIControls.Label(self, "BgPanel/BgAward/GridSpecialPanel/Icon2/Text")
end

function ActivitySeasonTowerBuffDlg:onShow(levelData, preLevelData, passedLayer)
	if levelData.score and levelData.score > 0 then
		self.textScore:setText("+" .. levelData.score or 0)
		self.panelScore:setVisible(true)
	else
		self.panelScore:setVisible(false)
	end

	ClientUtils.CreateBonusGrid(self, self.grids, "BgPanel/BgAward/GridPanel", levelData.award, true)

	local preDrop = 0

	if preLevelData then
		preDrop = preLevelData.hour_drop_count or 0
	end

	if levelData.hour_drop_count and preDrop < levelData.hour_drop_count then
		self.panelHook:setVisible(true)
		self.textHook:setText(string.format(Lang.get(30153), levelData.hour_drop_count - preDrop))
	else
		self.panelHook:setVisible(false)
	end

	local got = passedLayer >= levelData.layer

	for index, grid in ipairs(self.grids) do
		grid:setGet(got)
	end

	self:setVisible(true)
end

return ActivitySeasonTowerBuffDlg
