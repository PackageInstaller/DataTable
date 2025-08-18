-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\MallMultiPanel.lua

local UIControls = UIControls
local WelfarePanelBase = require("UI/Welfare/WelfarePanelBase")
local ResTmallShowConfig = require("ClientData/ResTmallShowConfig")
local MultiMallBigCell = Class("MultiMallBigCell", UIControls.Panel)

function MultiMallBigCell:ctor()
	self.imgBg = UIControls.RawImage(self, self.mPath .. "/ContentPanel/Bg")
	self.btnGo = UIControls.Button(self, self.mPath)

	self.btnGo:addEventClick(self.onGoClick)
end

function MultiMallBigCell:setData(tmallData)
	self.tmallData = tmallData

	if tmallData.icon then
		self.imgBg:setImage("NoAlpha/" .. tmallData.icon)
	end
end

function MultiMallBigCell:onGoClick()
	if self.tmallData.url then
		CurAvatar:jumpToOpenWebUrl(self.tmallData.url)
	end
end

local MultiMallSmallCell = Class("MultiMallSmallCell", UIControls.ScrollViewLoopCell)

function MultiMallSmallCell:ctor()
	self.imgBg = UIControls.RawImage(self, "ContentPanel/Bg")
	self.btnGo = UIControls.Button(self, "")

	self.btnGo:addEventClick(self.onGoClick)
end

function MultiMallSmallCell:setData(tmallData)
	self.tmallData = tmallData

	if tmallData.icon then
		self.imgBg:setImage("NoAlpha/" .. tmallData.icon)
	end
end

function MultiMallSmallCell:onGoClick()
	if self.tmallData.url then
		CurAvatar:jumpToOpenWebUrl(self.tmallData.url)
	end
end

local strClassName = "MallMultiPanel"
local MallMultiPanel = Class(strClassName, WelfarePanelBase)

function MallMultiPanel:ctor()
	self:initUI()
end

function MallMultiPanel:initUI()
	self.bigCell = MultiMallBigCell(self, "BigGridStoreShengHe")
	self.smallCells = {}
	self.scrollView = UIControls.ScrollViewLoopV(self, "AwardList", 0, self.onCellChanged)
end

function MallMultiPanel:initPanel()
	self.allData = {}

	for index, tMallId in ipairs(self.panelConfigData.value2 or {}) do
		if ResTmallShowConfig[tMallId] then
			table.insert(self.allData, ResTmallShowConfig[tMallId])
		end
	end

	if #self.allData > 1 then
		self.bigCell:setData(self.allData[1])
		self.scrollView:setTotalCount(#self.allData - 1)
	end
end

function MallMultiPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = MultiMallSmallCell(sender, "System/Common/Grid/GridStoreShengHe", newIdx, 0, 0)
		targetCell.mEventClick = self._slot4CellClick
	else
		self.smallCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.smallCells[newIdx] = targetCell

	targetCell:setData(self.allData[newIdx + 1])
end

return MallMultiPanel
