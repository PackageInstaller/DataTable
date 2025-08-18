-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeCleanDlg.lua

local strClassName = "MazeCleanDlg"
local MazeCleanDlg = Class(strClassName, UIControls.Window)

function MazeCleanDlg:ctor(...)
	self:initUI()
end

function MazeCleanDlg:initUI(...)
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtDesc = UIControls.Label(self, "BgPanel/TextDes")
	self.grids = {}
end

function MazeCleanDlg:onOpen(...)
	MazeCleanDlg.super.onOpen(self)
	self:show()
end

function MazeCleanDlg:show(...)
	self.txtDesc:setText(ClientUtils.getClientNotice(391))

	local items = CurAvatar.cachedMazeSweapAward

	CurAvatar.cachedMazeSweapAward = nil

	for i, item in ipairs(items or {}) do
		local cell = UIControls.getGridContainer(self, "BgPanel/AwardPanel")

		table.insert(self.grids, cell)
		cell:setObj(item)

		cell.grid.mDisableWays = true

		cell:setVisible(true)
	end
end

function MazeCleanDlg:setNewSweepMode()
	self.txtDesc:setText(ClientUtils.getClientNotice(672))
end

function MazeCleanDlg:onBtnConfirmClick(...)
	self:setVisible(false)

	for _, itemGrid in ipairs(self.grids) do
		if itemGrid:getVisible() then
			itemGrid.grid:flyToCommonFuncEntryPanel()
		end
	end
end

function MazeCleanDlg:destroy(...)
	MazeCleanDlg.super.destroy(self)

	CurAvatar.mazeChooseHallowLater = nil

	local ui = UIManager.getUI("mazeMainDlg", nil, false)

	if ui then
		ui:checkRelics()
	end
end

return MazeCleanDlg
