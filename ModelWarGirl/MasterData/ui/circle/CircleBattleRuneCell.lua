-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleRuneCell.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "CircleBattleRuneCell"
local CircleBattleRuneCell = Class(strClassName, UIControls.Child)

function CircleBattleRuneCell:ctor()
	self:initUI()
end

function CircleBattleRuneCell:initUI()
	self.imgIcon = UIControls.Image(self, "Icon")
	self.txtAttrName = UIControls.Label(self, "TextAttr")
	self.txtAttrValue = UIControls.Label(self, "TextAttrValue")
end

function CircleBattleRuneCell:setRune(runeData)
	self.runeData = runeData

	if self.runeData.resData.props and self.runeData.resData.props[1].type then
		local propName = BattleConst.PROP_TYPE_CONFIG[self.runeData.resData.props[1].type]
		local propValue = self.runeData.combineValue
		local zhName, attrValue = ClientUtils.getRolePropZhName(propName, propValue)

		self.txtAttrName:setText(zhName)
		self.txtAttrValue:setText(attrValue)

		local attriconInfo = ClientUtils.getRolePropIcon(propName)

		if self.imgIcon then
			self.imgIcon:setImage(attriconInfo[1], attriconInfo[2])
		end
	else
		self.txtAttrName:setText(self.runeData.resData.prop_desc)

		local propValue = tonumber(string.format("%.2f", self.runeData.combineValue / 100)) .. "%"

		self.txtAttrValue:setText(propValue)

		if self.imgIcon then
			self.imgIcon:setImage(self.runeData.resData.icon_path, self.runeData.resData.icon_name)
		end
	end
end

return CircleBattleRuneCell
