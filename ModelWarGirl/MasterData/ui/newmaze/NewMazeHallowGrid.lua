-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeHallowGrid.lua

local ResNewMazeRelic = require("ClientData/ResNewMazeRelic")
local strClassName = "NewMazeHallowGrid"
local NewMazeHallowGrid = Class(strClassName, UIControls.Child)

function NewMazeHallowGrid:ctor(...)
	self:initUI()
end

function NewMazeHallowGrid:initUI(...)
	self.iconHallow = UIControls.Image(self, "BgHead/IconHallow")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function NewMazeHallowGrid:setData(relicId)
	self.relicId = relicId

	if ResNewMazeRelic[relicId] and ResNewMazeRelic[relicId].icon_path then
		self.iconHallow:setImage(ResNewMazeRelic[relicId].icon_path, ResNewMazeRelic[relicId].icon_name)
	end
end

function NewMazeHallowGrid:onBtnSelfClick()
	if self.clickSelfFunc then
		self.clickSelfFunc(self)
	end
end

return NewMazeHallowGrid
