-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeFirstPassDlg.lua

local ResMaze = require("ClientData/ResMaze")
local ResRandClient = require("ClientData/ResRandClient")
local ResMazeConfig = require("ClientData/ResMazeConfig")
local strClassName = "MazeFirstPassDlg"
local MazeFirstPassDlg = Class(strClassName, UIControls.Window)

function MazeFirstPassDlg:ctor(...)
	self:initUI()
end

function MazeFirstPassDlg:initUI(...)
	self.btnHoldOn = UIControls.Button(self, "BgPanel/BtnHoldOn")

	self.btnHoldOn:addEventClick(self.onBtnHoldOnClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.itemGrids = {}
end

function MazeFirstPassDlg:show()
	local mazeData = CurAvatar.mazeData
	local totalLayer = #ResMaze[mazeData.maze_id]

	self.isAllFinish = totalLayer == mazeData.layer

	if false and self.isAllFinish then
		self.btnConfirm:setText(Lang.get(1480))
		self.btnHoldOn:setVisible(true)
	else
		self.btnConfirm:setText(Lang.get(422))
		self.btnHoldOn:setVisible(false)
	end

	local randId = ResMazeConfig[mazeData.maze_id][mazeData.layer].pass_award

	self:initAward(randId)
end

function MazeFirstPassDlg:initAward(randId)
	local bonus = ResRandClient[randId] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}

	for i = 1, #showNums do
		local newGrid = self.itemGrids[i]

		if not newGrid then
			newGrid = UIControls.getGridContainer(self, "BgPanel/AwardPanel")
			self.itemGrids[i] = newGrid
		end

		if showIds[i] then
			local id, num = showIds[i], showNums[i]
			local clientItem = BaseObject.GetObject(id, num)

			newGrid:setObj(clientItem)

			newGrid.grid.mDisableWays = true

			newGrid:setVisible(true)
		end
	end
end

function MazeFirstPassDlg:onBtnConfirmClick(...)
	self:_getAwards()

	if self.isAllFinish then
		CurAvatar:saveMazeCheckOpenInfo(CurAvatar.mazeData.maze_id + 1, 0)
		UIManager.getUI("mazeChooseDlg", true):show(true)
		self:setVisible(false)
	else
		self:setVisible(false)
	end
end

function MazeFirstPassDlg:_getAwards(...)
	MsgManager.notice(Lang.get(30573))

	for _, itemGrid in ipairs(self.itemGrids) do
		if itemGrid:getVisible() then
			itemGrid.grid:flyToCommonFuncEntryPanel()
		end
	end
end

function MazeFirstPassDlg.quitMaze(...)
	local ui = UIManager.getUI("mazeMainDlg", nil, false)

	if ui then
		ui:onBtnCloseClick()
	end
end

function MazeFirstPassDlg:onBtnHoldOnClick(...)
	self:setVisible(false)
	self:_getAwards()
end

function MazeFirstPassDlg:destroy(...)
	MazeFirstPassDlg.super.destroy(self)

	if self.quitTime then
		self.quitTime:Stop()
	end
end

return MazeFirstPassDlg
