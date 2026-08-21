-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\DeBuffTipsInfoPanel.lua

local NewMazeHallowGrid = require("UI/NewMaze/NewMazeHallowGrid")
local ResNewMazeRelic = require("ClientData/ResNewMazeRelic")
local ResNewMazeDeBuff = require("ClientData/ResNewMazeDeBuff")
local DebuffGrid = require("UI/NewMaze/DebuffGrid")
local strClassName = "DebuffTipsInfoPanel"
local DebuffTipsInfoPanel = Class(strClassName, UIControls.Child)

function DebuffTipsInfoPanel:ctor(...)
	self:initUI()
end

function DebuffTipsInfoPanel:initUI()
	self.textTitle = UIControls.Label(self, "TextTitle")
	self.textDes = UIControls.Label(self, "TextDes")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onGridDeBuffClick)
end

function DebuffTipsInfoPanel:setData(id, tipType)
	if tipType and tipType == Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic then
		if ResNewMazeRelic[id] then
			self.textTitle:setText(ResNewMazeRelic[id].name)
			self.textDes:setText(ResNewMazeRelic[id].description)

			if self.grid == nil then
				self.grid = NewMazeHallowGrid(self, "GridPanel", "System/Common/Grid/GridHallow", 0, 0, true)
			end

			self.grid:setData(id)
		end
	else
		self.buffId = id

		if ResNewMazeDeBuff[id] then
			self.textTitle:setText(ResNewMazeDeBuff[id].buff_name)
			self.textDes:setText(ResNewMazeDeBuff[id].buff_desc)

			if self.grid == nil then
				self.grid = DebuffGrid(self, "GridPanel", "System/Common/Grid/GridDeBuff", 0, 0, true)
			end

			self.grid:setData(self.buffId)
		end
	end
end

return DebuffTipsInfoPanel
