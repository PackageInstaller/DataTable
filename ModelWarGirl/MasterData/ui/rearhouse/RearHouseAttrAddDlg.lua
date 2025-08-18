-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseAttrAddDlg.lua

local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local strClassName = "RearHouseAttrAddDlg"
local RearHouseAttrAddDlg = Class(strClassName, UIControls.Window)

function RearHouseAttrAddDlg:ctor(...)
	self:initUI()

	self.timer = Timer.New(function(...)
		self:setVisible(false)
	end, 1.9, 1)

	self.timer:Start()
end

function RearHouseAttrAddDlg:initUI(...)
	return
end

function RearHouseAttrAddDlg:setData(data)
	self.data = data

	for i, _data in ipairs(data) do
		local cell = UIControls.Child(self, "AttrPanel", "System/Backyard/UnlockAttrPanel")

		cell.imgIcon = UIControls.Image(cell, "Icon")
		cell.txtDesc = UIControls.Label(cell, "TextAttr")

		cell:setVisible(true)

		if #_data.info.model_ids == 1 then
			local iconPath = RearHouseCommon.getSingleAttrIconAndDescs(_data.info)

			if iconPath then
				cell.imgIcon:setImage(iconPath[1], iconPath[2])
			end

			cell.txtDesc:setText(_data.desc)
		else
			cell.imgIcon:setVisible(false)
			cell.txtDesc:setText(_data.desc)
		end
	end
end

function RearHouseAttrAddDlg:destroy(...)
	RearHouseAttrAddDlg.super.destroy(self)
	RearHouseDragCenter.playShowEventByTurn()

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

return RearHouseAttrAddDlg
