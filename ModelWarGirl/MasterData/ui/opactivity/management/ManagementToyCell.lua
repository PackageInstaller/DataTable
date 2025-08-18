-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Management\\ManagementToyCell.lua

local ResBusinessToyConfig = require("ClientData/ResBusinessToyConfig")
local ManagementToyCell = Class("ManagementToyCell", UIControls.Child)

function ManagementToyCell:ctor()
	self.imgQuality = UIControls.Image(self, "ImgQuality")
	self.imgIcon = UIControls.Image(self, "ImgToy")
	self.imgLock = UIControls.Image(self, "ImgUnlock")
	self.txtNum = UIControls.Label(self, "Text")
	self.selectPanel1 = UIControls.Panel(self, "ImgSel")
	self.selectPanel2Bg = UIControls.Panel(self, "ImgChoose")
	self.selectPanel2 = UIControls.Panel(self, "ImgChoose/ImgSel")
	self.lvPanel = UIControls.Panel(self, "ImgLv")
	self.txtLv = UIControls.Label(self, "ImgLv/TextLv")
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onClickBtn)

	self.selectPanel = self.selectPanel1
end

function ManagementToyCell:init(showQuality, selectType, clickAction)
	self.showQuality = showQuality
	selectType = selectType or 1

	if selectType == 1 then
		self.selectPanel = self.selectPanel1
	elseif selectType == 2 then
		self.selectPanel2Bg:setVisible(true)

		self.selectPanel = self.selectPanel2
	end

	self.clickAction = clickAction
end

function ManagementToyCell:setData(actId, type, quality, strNum, checkLock)
	self.actId = actId
	self.type = type or 1
	self.quality = quality or 1
	self.maxQuality = #ResBusinessToyConfig[self.actId][self.type]
	self.checkMax = self.quality >= self.maxQuality
	checkLock = checkLock or false

	self.imgLock:setVisible(checkLock)
	self.imgIcon:setVisible(not checkLock)

	local itemId = ResBusinessToyConfig[self.actId][self.type][self.quality].item_id
	local object = BaseObject.GetObject(itemId)

	if not checkLock then
		local iconPath = object:getIconPath()

		if iconPath then
			self.imgIcon:setImage(iconPath[1], iconPath[2])
			self.imgIcon:setVisible(true)
		end
	end

	local qualityPath = object:getQualityPath()

	if qualityPath then
		self.imgQuality:setImage(qualityPath[1], qualityPath[2])
	end

	local checkNum = strNum ~= nil

	self.txtNum:setVisible(checkNum)

	if checkNum then
		self.txtNum:setText(strNum)
	end

	local checkQuality = self.showQuality == true

	self.txtLv:setVisible(checkQuality)

	if checkQuality then
		if Const.REVIEW_VERSION then
			self.txtLv:setText(self.checkMax and Lang.get(1699) or Lang.get(1203) .. self.quality)
		else
			self.txtLv:setText(self.checkMax and "Max" or "Lv." .. self.quality)
		end
	end
end

function ManagementToyCell:setSelect(value)
	self.selectPanel:setVisible(value)
end

function ManagementToyCell:setTxtNumColor(color)
	self.txtNum:setFontColor(color)
end

function ManagementToyCell:onClickBtn()
	if self.clickAction then
		self.clickAction(self)
	end
end

return ManagementToyCell
