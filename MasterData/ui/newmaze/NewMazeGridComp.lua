-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeGridComp.lua

local ResNewMazeFettersType = require("ClientData/ResNewMazeFettersType")
local NewMazeGridComp = {}
local NewMazeSolderGrid = Class("NewMazeSolderGrid", UIControls.Child)

function NewMazeSolderGrid:ctor(...)
	self:initUI()
end

function NewMazeSolderGrid:initUI(...)
	self.aniBg = UIControls.UIAni(self, "BgPanel")
	self.iconSolder = UIControls.Image(self, "BgPanel/IconSolder")
	self.textSolderName = UIControls.Label(self, "BgPanel/IconSolder/Text")
	self.imgSel = UIControls.Panel(self, "ImgSel")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onGridSensorClick)
end

function NewMazeSolderGrid:setData(solderId, notDefault, isPreview)
	self.solderId = solderId
	self.notDefault = notDefault
	self.isPreview = isPreview
	self.solderData = ResNewMazeFettersType[solderId] or {}
	self.solderData = self.solderData[1]

	if self.solderData then
		self.iconSolder:setVisible(true)
		self.iconSolder:setImage(self.solderData.icon_path, self.solderData.icon_name)
		self.textSolderName:setText(self.solderData.name)
	else
		self.iconSolder:setVisible(false)
	end

	if isPreview then
		self.aniBg:startAniLoop("GridSolder03")
	elseif notDefault then
		self.aniBg:startAni("GridSolder02")
	else
		self.aniBg:startAni("GridSolder01")
	end
end

function NewMazeSolderGrid:onGridSensorClick()
	if self.onGridClick then
		self.onGridClick(self)
	end
end

function NewMazeSolderGrid:setSelected(isSelected)
	if isSelected then
		self.imgSel:setVisible(true)
	else
		self.imgSel:setVisible(false)
	end
end

local NewMazeSolderItemGrid = Class("NewMazeSolderItemGrid", UIControls.Child)

function NewMazeSolderItemGrid:ctor(...)
	self:initUI()
end

function NewMazeSolderItemGrid:initUI(...)
	self.iconSolder = UIControls.Image(self, "IconSolder")
	self.textSolderNum = UIControls.Label(self, "TextNum")
	self.textSolderName = UIControls.Label(self, "TextName")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onGridSensorClick)

	self.aniSensor = UIControls.UIAni(self, "")
	self.panelOwned = UIControls.Panel(self, "ImgOwned")
end

function NewMazeSolderItemGrid:setData(solderId, num, itemId)
	self.solderId = solderId
	self.solderItemId = itemId
	self.solderData = ResNewMazeFettersType[solderId] or {}
	self.solderData = self.solderData[1]

	if self.solderData then
		self.iconSolder:setImage(self.solderData.icon_path, self.solderData.icon_name)
		self.textSolderName:setText(self.solderData.name)
	end

	self.textSolderNum:setText(num)
end

function NewMazeSolderItemGrid:onGridSensorClick()
	if self.onGridClick then
		self.onGridClick(self)
	end
end

function NewMazeSolderItemGrid:setSelected(isSelected)
	if isSelected then
		self.aniSensor:startAni("GridEnchantSel")
	else
		self.aniSensor:startAni("GridEnchantNml")
	end
end

function NewMazeSolderItemGrid:setOwned(isOwned)
	self.panelOwned:setVisible(isOwned)
end

NewMazeGridComp.SolderGrid = NewMazeSolderGrid
NewMazeGridComp.SolderItemGrid = NewMazeSolderItemGrid

return NewMazeGridComp
