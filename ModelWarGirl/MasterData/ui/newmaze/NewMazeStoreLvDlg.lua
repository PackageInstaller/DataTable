-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeStoreLvDlg.lua

local ResColor = require("ClientData/ResColor")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "StoreOddsCell"
local StoreOddsCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function StoreOddsCell:ctor()
	self:initUI()
end

function StoreOddsCell:initUI()
	self.textLabelOdds1 = UIControls.Label(self, "TextLabelOdds1")
	self.textLabelOdds2 = UIControls.Label(self, "TextLabelOdds2")
	self.textLabelOdds3 = UIControls.Label(self, "TextLabelOdds3")
	self.textLabelOdds4 = UIControls.Label(self, "TextLabelOdds4")
	self.textLv = UIControls.Label(self, "TextLv")
end

function StoreOddsCell:setData(data)
	self.data = data

	self.textLabelOdds1:setText(self.data.label_rate1 .. "%")
	self.textLabelOdds2:setText(self.data.label_rate2 .. "%")
	self.textLabelOdds3:setText(self.data.label_rate3 .. "%")
	self.textLabelOdds4:setText(string.format(Lang.get(70029), self.data.allow_equip_halo_num))
	self.textLv:setText(string.format("Lv%d", self.data.shop_level))

	if self.mParent.curShopLv == self.data.shop_level then
		self.textLabelOdds1:setFontColor(ResColor.ORANGE)
		self.textLabelOdds2:setFontColor(ResColor.ORANGE)
		self.textLabelOdds3:setFontColor(ResColor.ORANGE)
		self.textLabelOdds4:setFontColor(ResColor.ORANGE)
		self.textLv:setFontColor(ResColor.ORANGE)
	end
end

local strClassName = "NewMazeStoreLvDlg"
local NewMazeStoreLvDlg = Class(strClassName, UIControls.Window)

function NewMazeStoreLvDlg:ctor()
	self:initUI()
end

function NewMazeStoreLvDlg:initUI()
	self.textRule = UIControls.Label(self, "BgPanel/MainInfoPanel/TextRule")
	self.oddsListPanel = UIControls.ScrollViewLoopV(self, "BgPanel/MainInfoPanel/OddsPanel/OddsListPanel")

	self.oddsListPanel:addEventCellChanged(self.onCellChanged)

	self.cells = {}
end

function NewMazeStoreLvDlg:setData(shopData, curShopLv)
	self.curShopLv = curShopLv
	self.shopData = {}

	self.textRule:setText(ResNewMazeDisplay[13060017].desc)

	for i, v in pairs(shopData) do
		table.insert(self.shopData, v)
	end

	table.sort(self.shopData, function(a, b)
		return a.shop_level < b.shop_level
	end)
	self.oddsListPanel:setTotalCount(#self.shopData, math.min(#self.shopData - 3, self.curShopLv))
end

function NewMazeStoreLvDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = StoreOddsCell(sender, "System/Rogue/RogueStoreOddsCell", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setData(self.shopData[newIdx])
	targetCell:setVisible(true)
end

return NewMazeStoreLvDlg
