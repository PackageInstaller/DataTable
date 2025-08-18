-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeTalentGrid.lua

local ResNewMazeTalent = require("ClientData/ResNewMazeTalent")
local NewMazeTalentGrid = Class("NewMazeTalentGrid", UIControls.Child)

function NewMazeTalentGrid:ctor()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)

	self.textName = UIControls.Label(self, "Text")
	self.iconTalent = UIControls.Image(self, "IconSkill")
	self.levelUIs = {}

	for index = 1, 5 do
		local uis = {}
		local uiPath = "LvPanel/LvStatePanel" .. index

		uis.imgOk = UIControls.Panel(self, uiPath .. "/ImgDis")
		uis.imgPreview = UIControls.Panel(self, uiPath .. "/ImgPreview")
		uis.imgLock = UIControls.Panel(self, uiPath .. "/ImgLock")

		table.insert(self.levelUIs, uis)
	end

	self.panelLock = UIControls.Panel(self, "LockPanel")
	self.iconNew = UIControls.Panel(self, "Efx")
	self.mEventCellClick = nil
end

function NewMazeTalentGrid:setSelected(isSelected)
	if isSelected then
		self.btnSensor:setEnable(false)
	else
		self.btnSensor:setEnable(true)
	end
end

function NewMazeTalentGrid:setData(groupId)
	self.groupId = groupId
	self.groupData = ResNewMazeTalent[groupId]

	local showData = self.groupData[1]

	if showData.iconPath then
		self.iconTalent:setImage(showData.iconPath, showData.icon)
	end

	self.textName:setText(showData.name)
end

function NewMazeTalentGrid:setLevel(level, previewLevel)
	local oldLevel = self.level

	self.level = level
	self.previewLevel = previewLevel

	for index, uiTable in ipairs(self.levelUIs) do
		if index <= self.level then
			uiTable.imgOk:setVisible(true)
			uiTable.imgPreview:setVisible(false)
			uiTable.imgLock:setVisible(false)
		elseif index <= level + previewLevel then
			uiTable.imgOk:setVisible(false)
			uiTable.imgPreview:setVisible(true)
			uiTable.imgLock:setVisible(false)
		else
			uiTable.imgOk:setVisible(false)
			uiTable.imgPreview:setVisible(false)
			uiTable.imgLock:setVisible(true)
		end
	end

	self.panelLock:setVisible(level + previewLevel == 0)
end

function NewMazeTalentGrid:refreshUpEnable()
	local curPoint = 0
	local curLevelData = self.groupData[self.level + self.previewLevel]

	if curLevelData then
		curPoint = curLevelData.need_point
	end

	local nextLevelData = self.groupData[self.level + self.previewLevel + 1]

	if nextLevelData and (not nextLevelData.unlock_cycle or not (nextLevelData.unlock_cycle > self.mParent.curCycle)) and self.mParent.havePoint >= nextLevelData.need_point - curPoint then
		self.iconNew:setVisible(true)

		return
	end

	self.iconNew:setVisible(false)
end

function NewMazeTalentGrid:onSensorClick()
	if self.mEventCellClick then
		self:mEventCellClick(self)
	end
end

return NewMazeTalentGrid
