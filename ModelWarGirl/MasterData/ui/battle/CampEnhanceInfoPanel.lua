-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\CampEnhanceInfoPanel.lua

local ResColor = require("ClientData/ResColor")
local ResBattleEnhance = require("ClientData/ResBattleEnhance")
local CampEnhanceInfoCell = Class("CampEnhanceInfoCell", UIControls.Panel)

function CampEnhanceInfoCell:ctor()
	self:initUI()
end

function CampEnhanceInfoCell:initUI()
	self.imgCell = UIControls.Image(self, self.mPath .. "/Icon")
	self.textNeed = UIControls.Label(self, self.mPath .. "/TextDes")
	self.textAttr = UIControls.Label(self, self.mPath .. "/AttrPanel/TextAttr1")
	self.imgMask = UIControls.Panel(self, self.mPath .. "/IconMask")
end

function CampEnhanceInfoCell:setData(enhanceData, nowNumber)
	local enhanceNumber = enhanceData.enhance_args
	local pathPlayer = UIConst.CAMP_ENHANCE_BTN_IMG_BIG[enhanceNumber] or UIConst.CAMP_ENHANCE_BTN_IMG_BIG[0]

	self.imgCell:setImage(pathPlayer[1], pathPlayer[2])
	self.textNeed:setText(enhanceData.need_desc or "")
	self.textAttr:setText(enhanceData.eff_desc or "")

	if nowNumber < enhanceNumber then
		self.imgMask:setVisible(true)
		self.imgCell:setImageGray(true)
		self.textNeed:setFontColor(ResColor.GREYMIDDLE)
		self.textAttr:setFontColor(ResColor.GREYMIDDLE)
	else
		self.imgMask:setVisible(false)
		self.imgCell:setImageGray(false)
		self.textNeed:setFontColor(ResColor.WHITE)

		if nowNumber == enhanceNumber then
			self.textAttr:setFontColor(ResColor.ORANGE)
		else
			self.textAttr:setFontColor(ResColor.WHITE)
		end
	end
end

local SpecialCampEnhanceInfoCell = Class("SpecialCampEnhanceInfoCell", UIControls.Panel)

function SpecialCampEnhanceInfoCell:ctor()
	self:initUI()
end

function SpecialCampEnhanceInfoCell:initUI()
	self.imgCell = UIControls.Image(self, self.mPath .. "/Icon")
	self.textNeed = UIControls.Label(self, self.mPath .. "/TextDes")
	self.textAttr = UIControls.Label(self, self.mPath .. "/AttrPanel/TextAttr1")
	self.imgMask = UIControls.Panel(self, self.mPath .. "/IconMask")
	self.slider = UIControls.MaterialProgress(self, self.mPath .. "/ImgProgress")
end

function SpecialCampEnhanceInfoCell:setData(enhanceData, nowActive)
	self.textNeed:setText(enhanceData.need_desc or "")
	self.textAttr:setText(enhanceData.eff_desc or "")

	if nowActive then
		self.imgMask:setVisible(false)
		self.imgCell:setImageGray(false)
		self.textNeed:setFontColor(ResColor.WHITE)
		self.textAttr:setFontColor(ResColor.WHITE)
		self.slider:setValue(enhanceData.enhance_args * 0.2)
	else
		self.imgMask:setVisible(true)
		self.imgCell:setImageGray(true)
		self.textNeed:setFontColor(ResColor.GREYMIDDLE)
		self.textAttr:setFontColor(ResColor.GREYMIDDLE)
		self.slider:setValue(0)
	end
end

local CampEnhanceInfoPanel = Class("CampEnhanceInfoPanel", UIControls.Panel)

function CampEnhanceInfoPanel:ctor()
	self:initUI()
end

local MAX_NUM = 3

function CampEnhanceInfoPanel:initUI()
	self.cells = {}

	for index = 1, MAX_NUM do
		local newCell = CampEnhanceInfoCell(self, self.mPath .. "/GroupInfo" .. index)

		table.insert(self.cells, newCell)
	end

	self.brightCell = SpecialCampEnhanceInfoCell(self, self.mPath .. "/GroupInfo4")
	self.darknessCell = SpecialCampEnhanceInfoCell(self, self.mPath .. "/GroupInfo5")
	self.brightData = {}
	self.darknessData = {}

	for index, info in ipairs(ResBattleEnhance) do
		if info.enhance_type == 3 then
			self.brightData[info.enhance_args] = info
		elseif info.enhance_type == 4 then
			self.darknessData[info.enhance_args] = info
		end
	end
end

function CampEnhanceInfoPanel:onShow(nowNumber, brightNum, darknessNum)
	for index = 1, MAX_NUM do
		self.cells[index]:setData(ResBattleEnhance[index], nowNumber)
	end

	if brightNum >= 1 then
		self.brightCell:setData(self.brightData[brightNum], true)
	else
		self.brightCell:setData(self.brightData[1], false)
	end

	if darknessNum >= 1 then
		self.darknessCell:setData(self.darknessData[darknessNum], true)
	else
		self.darknessCell:setData(self.darknessData[1], false)
	end
end

return CampEnhanceInfoPanel
