-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\WorldBoss\\WorldBossPointAwardGetDlg.lua

local ResWorldBossMisc = require("ClientData/ResWorldBossMisc")
local WorlBossPointAwardGetCell = Class("WorlBossPointAwardGetCell", UIControls.Child)

function WorlBossPointAwardGetCell:ctor(...)
	self:initUI()
end

function WorlBossPointAwardGetCell:initUI(...)
	self.txtNum = UIControls.Label(self, "ContentPanel/TextNum")
	self.awardCells = {}
end

function WorlBossPointAwardGetCell:setData(data)
	self.txtNum:setText(ClientUtils.getNumShortStr(data.score))
	ClientUtils.CreateBonusGrid(self, self.awardCells, "ContentPanel/AwardPanel", data.awardid, true, nil, true)

	for i, cell in ipairs(self.awardCells) do
		if cell.object.id == ResWorldBossMisc[1].award_id and data.up_ratio then
			cell:setNumSpe(true, "+" .. data.up_ratio * 0.01)
		else
			cell:setNumSpe(false)
		end
	end
end

local strClassName = "WorldBossPointAwardGetDlg"
local WorldBossPointAwardGetDlg = Class(strClassName, UIControls.Window)

function WorldBossPointAwardGetDlg:ctor(...)
	self:initUI()
end

function WorldBossPointAwardGetDlg:initUI(...)
	return
end

function WorldBossPointAwardGetDlg:onOpen(...)
	WorldBossPointAwardGetDlg.super.onOpen(self)
end

function WorldBossPointAwardGetDlg:show(data)
	self.cells = {}

	for i, info in ipairs(data) do
		local cell = WorlBossPointAwardGetCell(self, "Bg/AwardList/Content", "System/WorldBoss/WorldBossPointAwardGetCell")

		cell:setData(info.info)
		cell:setVisible(true)
		table.insert(self.cells, cell)
	end
end

function WorldBossPointAwardGetDlg:destroy(...)
	for _, cell in ipairs(self.cells) do
		for _, itemGrid in ipairs(cell.awardCells) do
			if itemGrid:getVisible() then
				itemGrid.grid:flyToCommonFuncEntryPanel()
			end
		end
	end

	WorldBossPointAwardGetDlg.super.destroy(self)
end

return WorldBossPointAwardGetDlg
