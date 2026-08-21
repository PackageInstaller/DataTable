-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivitySweepInfoDlg.lua

local strClassName = "ActivitySweepInfoDlg"
local ActivitySweepInfoDlg = Class(strClassName, UIControls.Window)
local ActSweepInfoCell = Class("ActSweepInfoCell", UIControls.Child)

function ActSweepInfoCell:ctor(...)
	self:initUI()
end

function ActSweepInfoCell:initUI()
	self.stageNametxt = UIControls.Label(self, "TitlePanel/TxtName")
	self.stageLockImg = UIControls.Image(self, "TitlePanel/ImgLock")
	self.costImg = UIControls.Image(self, "UsePanel/IconUse")
	self.costNumTxt = UIControls.Label(self, "UsePanel/TxtUse")
	self.panelTitle = UIControls.Panel(self, "UsePanel/TxtTitle")
	self.grids = {}
end

function ActSweepInfoCell:setSweepInfo(levelData, levelState, costItemId)
	if #self.grids > 0 then
		for i = #self.grids, 1, -1 do
			self.grids[i]:destroy()

			self.grids[i] = nil
		end
	end

	self.grids = {}

	local awardId = levelData.sweep_bonus

	ClientUtils.CreateBonusGrid(self, self.grids, "GridPanel", awardId, nil, nil, true)
	self.stageNametxt:setText(levelData.name or "")
	self.costNumTxt:setText(string.format(Lang.get(30627), levelData.sweep_cost or 60))
	self.stageLockImg:setVisible(levelState == Const.COMMON_STATE_LOCK)

	if costItemId then
		local itemPath = BaseObject.getItemIconPath(costItemId)

		if itemPath then
			self.costImg:setImage(itemPath[1], itemPath[2])
		end
	end

	if RegionUtils.isJP() then
		self.panelTitle:setVisible(false)
	end
end

function ActivitySweepInfoDlg:ctor(...)
	self:initUI()
end

function ActivitySweepInfoDlg:initUI(...)
	self.cellPath = "Bg/AwardListPanel/Content"
	self.cells = {}
	self.closeBtn = UIControls.Button(self, "Bg/BtnClose")

	self.closeBtn:addEventClick(self.onClickClose)
end

function ActivitySweepInfoDlg:setSweepInfo(allLevelData, actData)
	local costItemId = actData.miscData.cost_item_id
	local levelDataList = {}

	for _, levelDatas in pairs(allLevelData) do
		for _, levelData in ipairs(levelDatas) do
			table.insert(levelDataList, levelData)
		end
	end

	table.sort(levelDataList, function(a, b)
		return a.index < b.index
	end)

	for i, levelData in ipairs(levelDataList) do
		if not self.cells[i] then
			local cell = ActSweepInfoCell(self, self.cellPath, "System/Activity/ActivityFlot/GridActCleanAward", 0, 0, true)

			self.cells[i] = cell
		end

		self.cells[i]:setSweepInfo(levelData, actData:getLevelState(levelData.index), costItemId)
	end

	if #self.cells > #levelDataList then
		for i = #self.cells, #levelDataList + 1, -1 do
			self.cells[i]:destroy()

			self.cells[i] = nil
		end
	end
end

function ActivitySweepInfoDlg:onClickClose(...)
	self:setVisible(false)
end

return ActivitySweepInfoDlg
