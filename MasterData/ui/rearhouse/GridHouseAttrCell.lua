-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\GridHouseAttrCell.lua

local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local ResRearHouse = require("ClientData/ResRearHouse")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local ResItem = require("ClientData/ResItem")
local ResColor = require("ClientData/ResColor")
local GridHouseAttrCell = Class("GridHouseAttrCell", UIControls.Child)
local MODE = {
	PUTED = 2,
	HAVE = 1,
	HAVE_NOT_PUT = 3,
	NOT_HAVE = 4
}

function GridHouseAttrCell:ctor(...)
	self:initUI()
end

function GridHouseAttrCell:initUI(...)
	self.panelFurniture = UIControls.Panel(self, "FurniturePanel")
	self.panelAttr = UIControls.Panel(self, "AttrPanel")
	self.panelNotHave = UIControls.Panel(self, "FurniturePanel/NonePanel1")
	self.panelNotPut = UIControls.Panel(self, "FurniturePanel/NonePanel2")
	self.imgIcon = UIControls.Image(self, "FurniturePanel/Icon")
	self.imgAttr = UIControls.Image(self, "AttrPanel/Icon")
	self.imgBg = UIControls.Image(self, "FurniturePanel/Bg")
	self.imgBgTitle = UIControls.Image(self, "FurniturePanel/BgTitle")
	self.txtName = UIControls.Label(self, "FurniturePanel/TextName")
	self.txtType = UIControls.Label(self, "FurniturePanel/TextType")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.txtAttrs = {}

	for i = 1, 2 do
		local panel = UIControls.Panel(self, "AttrPanel/Attr" .. i)
		local txtDesc = UIControls.Label(self, "AttrPanel/Attr" .. i .. "/TextAttr")

		table.insert(self.txtAttrs, {
			panel,
			txtDesc
		})
	end

	self.clickCallBack = nil
	self.descNum = 0
end

function GridHouseAttrCell:setData(mid)
	local data = RearHouseCommon.getAttrInfoByMid(mid)

	self.data = data
	self.ownNotPut = nil
	self.needTip = nil
	self.mid = mid

	if mid then
		local info = ResRearHouse[mid]

		self.houseInfo = info

		if info then
			local layerInfo = ResRearHouseLayer[info.type_id]

			self.txtType:setText(layerInfo.type_name)
		end

		local itemInfo = ResItem[mid]

		if itemInfo then
			self.txtName:setText(itemInfo.name)
		end

		if itemInfo and itemInfo.iconPath then
			self.imgIcon:setImage(UIConst.ITEM_ICON_PATH .. itemInfo.iconPath, itemInfo.icon)
		end
	end

	self.descNum = 0

	if #data.model_ids == 1 then
		self.panelAttr:setVisible(true)

		local iconPath, strs = RearHouseCommon.getSingleAttrIconAndDescs(data)

		if strs then
			self.descNum = #strs

			for i = 1, #self.txtAttrs do
				local info = self.txtAttrs[i]

				if strs[i] then
					info[1]:setVisible(true)
					info[2]:setText(strs[i])
				else
					info[1]:setVisible(false)
				end
			end
		end

		if iconPath then
			self.imgAttr:setImage(iconPath[1], iconPath[2])
		end
	else
		self.panelAttr:setVisible(false)
	end
end

function GridHouseAttrCell:setHouseMode(putedMap, isMyHouse)
	if putedMap[self.mid] then
		self.imgIcon:setImageGray(false)
		self.panelNotPut:setVisible(false)
		self.panelNotHave:setVisible(false)
		self:setModeUI(MODE.PUTED)
	else
		self:setModeUI(MODE.NOT_HAVE)

		self.needTip = true

		self.imgIcon:setImageGray(true)

		if isMyHouse then
			if CurAvatar:getItemNumById(self.mid) > 0 then
				self.ownNotPut = true

				self.panelNotPut:setVisible(true)
			else
				self.panelNotHave:setVisible(true)
			end
		end
	end
end

function GridHouseAttrCell:setShopMode(ownMap)
	if ownMap[self.mid] and ownMap[self.mid] > 0 then
		self.imgIcon:setImageGray(false)
		self.panelNotPut:setVisible(false)
		self.panelNotHave:setVisible(false)
		self:setModeUI(MODE.HAVE)
	else
		self:setModeUI(MODE.NOT_HAVE)

		self.needTip = true

		self.imgIcon:setImageGray(true)
	end

	self.imgBgTitle:setVisible(false)
	self.txtName:setVisible(false)
	self.txtType:setVisible(false)
end

function GridHouseAttrCell:setModeUI(mode)
	if mode == MODE.HAVE or mode == MODE.PUTED then
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardAtlas", "BgHave")
		self.txtName:setFontColor(ResColor.WHITE)
		self.txtType:setFontColor(ResColor.WHITE)

		for i = 1, #self.txtAttrs do
			self.txtAttrs[i][2]:setFontColor(ResColor.ORANGEBTN)
		end
	else
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardAtlas", "BgHaveDis")
		self.txtName:setFontColor(ResColor.GREYLIGHT)
		self.txtType:setFontColor(ResColor.GREYLIGHT)

		for i = 1, #self.txtAttrs do
			self.txtAttrs[i][2]:setFontColor(ResColor.GREYLIGHT)
		end
	end
end

function GridHouseAttrCell:getDescNum(...)
	return self.descNum or 0
end

function GridHouseAttrCell:onBtnSensorClick(...)
	if self.clickCallBack ~= nil then
		self.clickCallBack(self.mid)
	end
end

return GridHouseAttrCell
