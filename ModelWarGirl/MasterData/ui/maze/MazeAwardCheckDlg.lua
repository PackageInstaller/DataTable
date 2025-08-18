-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeAwardCheckDlg.lua

local ResMazeConfig = require("ClientData/ResMazeConfig")
local ResRandClient = require("ClientData/ResRandClient")
local ResColor = require("ClientData/ResColor")
local strClassName = "MazeAwardCheckDlg"
local MazeAwardCheckDlg = Class(strClassName, UIControls.Window)
local DIFF_COLOR = {
	"WHITE",
	"ORANGEBTN",
	"RED01"
}

function MazeAwardCheckDlg:ctor(...)
	self:initUI()
end

function MazeAwardCheckDlg:initUI(...)
	self.awardCells = {}

	for i = 1, 3 do
		local path = "Bg/AwardDifficulty" .. i
		local cell = UIControls.Panel(self, path)

		cell.txtDiff = UIControls.Label(self, path .. "/TextDifficulty")
		cell.imgGet = UIControls.Image(self, path .. "/ImgGet")
		cell.imgDiff = UIControls.Image(self, path .. "/BgDifficulty")
		cell.mPath = path
		cell.awardCells = {}

		table.insert(self.awardCells, cell)
	end
end

function MazeAwardCheckDlg:show(mazeRecord)
	self.mazeRecord = mazeRecord

	self:initAward()
end

function MazeAwardCheckDlg:initAward(...)
	local mazeData = ResMazeConfig[self.mazeRecord.mazeId]

	for i, mazeInfo in ipairs(mazeData) do
		local id = mazeInfo.pass_award

		id = tonumber(id)

		local bonus = ResRandClient[id] or {}
		local showIds = bonus.show_ids or {}
		local showNums = bonus.show_nums or {}
		local cell = self.awardCells[i]

		cell.imgDiff:setImage("Atlas/MazeAtlas/MazeAtlas", "BgDifficulty" .. mazeInfo.difficult_flag)
		cell.txtDiff:setText(mazeInfo.difficult_desc)
		cell.txtDiff:setFontColor(ResColor[DIFF_COLOR[mazeInfo.difficult_flag]])

		local isGot = i <= self.mazeRecord.layer

		cell.imgGet:setVisible(isGot)

		for j = 1, #showNums do
			if showIds[j] then
				local newGrid = cell.awardCells[j]

				if newGrid == nil then
					newGrid = UIControls.getGridContainer(self, cell.mPath .. "/GridPanel")

					table.insert(cell.awardCells, newGrid)
				end

				local clientItem = BaseObject.GetObject(showIds[j], showNums[j])

				newGrid:setObj(clientItem)
				newGrid:setVisible(true)

				newGrid.grid.mDisableWays = true

				newGrid:setObjGray(isGot)
			end
		end
	end

	for i = #mazeData + 1, #self.awardCells do
		self.awardCells[i]:setVisible(false)
	end
end

return MazeAwardCheckDlg
