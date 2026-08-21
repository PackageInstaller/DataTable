-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\EvoEquipReturnPanel.lua

local strClassName = "EvoEquipReturnPanel"
local EvoEquipReturnPanel = Class(strClassName, UIControls.Panel)
local ResEquipReturn = require("ClientData/ResEquipReturn")

function EvoEquipReturnPanel:ctor()
	self:initUI()
end

function EvoEquipReturnPanel:initUI()
	self.btnClickThrough = UIControls.Button(self, self.mPath .. "/BtnClickThrough")

	self.btnClickThrough:addEventClick(self.onBtnClickThroughClick)

	self.txtReturn = UIControls.Label(self, self.mPath .. "/ItemReturnPanel/TextReturn")
end

function EvoEquipReturnPanel:onBtnClickThroughClick()
	self:setVisible(false)
end

function EvoEquipReturnPanel:setEquip(equip)
	self.equip = equip

	if self.equip.evolve > 0 then
		self.txtReturn:setText(ClientUtils.getClientNotice(643))

		self.returnGridList = {}

		local evoReturnData = ResEquipReturn[self.equip.evolve][self.equip.part]

		for i, v in ipairs(evoReturnData.ret_item or {}) do
			local returnGrid = UIControls.ItemGridChild(self, self.mPath .. "/ItemReturnPanel/ItemReturn", "System/Common/Grid/GridMaterialItem", 0, 0, true)
			local item = BaseObject.GetObject(v.id, v.num)

			returnGrid:setObj(item)

			if returnGrid.btnSensor then
				returnGrid.btnSensor:setEnable(false)
			end
		end
	end
end

return EvoEquipReturnPanel
