-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeFinishDlg.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResMazeMisc = require("ClientData/ResMazeMisc")
local strClassName = "MazeFinishDlg"
local MazeFinishDlg = Class(strClassName, UIControls.Window)

function MazeFinishDlg:ctor(...)
	self:initUI()
end

function MazeFinishDlg:initUI(...)
	self.btnHoldOn = UIControls.Button(self, "BgPanel/BtnHoldOn")

	self.btnHoldOn:addEventClick(self.onBtnHoldOnClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtTips = UIControls.Label(self, "BgPanel/TextTips")
	self.itemGrids = {}
end

function MazeFinishDlg:onOpen(...)
	MazeFinishDlg.super.onOpen(self)
	self:refreshTime()
end

function MazeFinishDlg:setData(branchData, branchIndex, baseData, isFirstPass)
	self.branchIndex = branchIndex
	self.branchData = branchData
	self.isFirstPass = isFirstPass

	if true or self.isFirstPass then
		self.btnConfirm:setText(Lang.get(104))
		self.btnHoldOn:setVisible(false)
	else
		self.btnConfirm:setText(Lang.get(1480))
		self.btnHoldOn:setVisible(true)
	end

	local data = {}

	data.itemBonus = {}

	local hasExtra = CurAvatar:hasPrivilegeType(Const.PRIVITY_KEY_EBONUS_MAZE)
	local bonus = ResRandClient[branchData.param[1]] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}

	for i = 1, #showNums do
		local newGrid = self.itemGrids[i]

		if not newGrid then
			newGrid = UIControls.getGridContainer(self, "BgPanel/AwardList")
			self.itemGrids[i] = newGrid
		end

		if showIds[i] then
			local id, num = showIds[i], showNums[i]
			local extraValue = 0

			if hasExtra then
				extraValue = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_EBONUS_MAZE, num, true)
			end

			if id == Const.MONEY_ID_MAZE then
				num = math.floor(CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_MAZE_COIN, num))
			elseif id == Const.MONEY_ID_GOLD then
				num = math.floor(CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_MAZE_GOLD, num))
			end

			num = num + extraValue

			local clientItem = BaseObject.GetObject(id, num)

			newGrid:setObj(clientItem)

			newGrid.grid.mDisableWays = true

			newGrid:setVisible(true)
		end
	end

	if #self.itemGrids > #showNums then
		for i = #showNums + 1, #self.itemGrids do
			self.itemGrids[i]:setVisible(false)
		end
	end
end

function MazeFinishDlg:refreshTime(...)
	local leftTime = CurAvatar:getMazeLeftTime()

	ClientTimerManager.RemoveSecondTickUI(self.txtTips)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTips, leftTime, nil, Lang.get(30571), nil, nil)
end

function MazeFinishDlg:onBtnConfirmClick(...)
	self:_getAwards()

	if self.isFirstPass then
		UIManager.getUI("mazeFirstPassDlg", true):show()
	else
		UIManager.getUI("mazeChooseDlg", true):show(true)
	end

	self:setVisible(false)
end

function MazeFinishDlg:quitMaze(...)
	local ui = UIManager.getUI("mazeMainDlg", nil, false)

	if ui then
		ui:onBtnCloseClick()
	end
end

function MazeFinishDlg:_getAwards(...)
	MsgManager.notice(Lang.get(30572))

	for _, itemGrid in ipairs(self.itemGrids) do
		if itemGrid:getVisible() then
			itemGrid.grid:flyToCommonFuncEntryPanel()
		end
	end

	RPC.mazeSelectBranch(self.branchIndex)
end

function MazeFinishDlg:onBtnHoldOnClick(...)
	self:_getAwards()
	self:setVisible(false)
end

function MazeFinishDlg:destroy(...)
	MazeFinishDlg.super.destroy(self)

	if self.quitTime then
		self.quitTime:Stop()
	end
end

return MazeFinishDlg
