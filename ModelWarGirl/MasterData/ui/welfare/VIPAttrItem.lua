-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\VIPAttrItem.lua

local ResVIP = require("ClientData/ResVIP")
local VIPAttrItem = Class("VIPAttrItem", UIControls.Child)

function VIPAttrItem:ctor()
	self.imgSource = UIControls.Image(self, "")
	self.imgIcon = UIControls.Image(self, "Icon")
	self.imgSel = UIControls.Image(self, "ImgSel")
	self.imgUp = UIControls.Image(self, "ImgUp")
	self.imgNew = UIControls.Image(self, "ImgNew")
	self.btn = UIControls.Button(self, "", "Text")

	self.btn:addEventClick(self.onBtnClick)
end

function VIPAttrItem:setData(data, state, level)
	self.beSelected = false
	self.data = data

	self.btn:setText(data.name)

	if data.icon_path and data.icon then
		self.imgIcon:setImage("Atlas/StoreAtlas/" .. data.icon_path, data.icon)
	end

	if not state then
		self.imgIcon:setObjGray(false)
		self:showNewAndUp(data, level)
	elseif state == 2 then
		self.imgIcon:setObjGray(false)
		self.imgNew:setVisible(false)
		self.imgUp:setVisible(false)
	else
		self.imgIcon:setObjGray(true)
		self:showNewAndUp(data, level)
	end
end

function VIPAttrItem:showNewAndUp(data, level)
	if ResVIP[level - 1] then
		local lastVipPriData = CurAvatar:getVipClientData(level - 1).priIdByType

		if not lastVipPriData[data.type] then
			self.imgNew:setVisible(true)
			self.imgUp:setVisible(false)
		else
			self.imgNew:setVisible(false)

			if not lastVipPriData[data.type][data.id] then
				self.imgUp:setVisible(true)
			else
				self.imgUp:setVisible(false)
			end
		end
	end
end

function VIPAttrItem:setSelect(isSelect)
	self.beSelected = isSelect

	if isSelect == true then
		self.imgSource:setImage("Atlas/StoreAtlas/StoreVIPAtlas", "BgPropsBottomArrow")
		self.imgSel:setVisible(true)
	else
		self.imgSource:setImage("Atlas/StoreAtlas/StoreVIPAtlas", "BgPropsBottom")
		self.imgSel:setVisible(false)
	end
end

function VIPAttrItem:onBtnClick()
	local state = not self.beSelected

	self.beSelected = not self.beSelected

	if self.mEventClick then
		self.mEventClick(self.data, state)
		self:setSelect(state)
	end
end

return VIPAttrItem
