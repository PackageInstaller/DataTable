-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\PanelSingleFurnitrue.lua

local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local strClassName = "PanelSingleFurniture"
local PanelSingleFurniture = Class(strClassName, UIControls.Child)

function PanelSingleFurniture:ctor(...)
	self:initUI()
end

function PanelSingleFurniture:initUI(...)
	self.txtRule = UIControls.Label(self, "TextRule")
	self.imgAttr = UIControls.Image(self, "AttrPanel/Icon")
	self.txtAttrs = {}

	for i = 1, 2 do
		local panel = UIControls.Panel(self, "AttrPanel/Attr" .. i)
		local txtDesc = UIControls.Label(self, "AttrPanel/Attr" .. i .. "/TextAttr")

		table.insert(self.txtAttrs, {
			panel,
			txtDesc
		})
	end
end

function PanelSingleFurniture:setData(mid)
	local data = RearHouseCommon.getAttrInfoByMid(mid)

	self.txtRule:setText(Lang.get(30544))

	local iconPath, strs = RearHouseCommon.getSingleAttrIconAndDescs(data)

	if strs then
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
end

return PanelSingleFurniture
