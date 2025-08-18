-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\ShortNumLabel.lua

local Label = require("UI/Control/Com/Label")
local UIConst = UIConst
local strClassName = "ShortNumLabel"
local ShortNumLabel = Class(strClassName, Label)

function ShortNumLabel:ctor(parent, path, canEmoji)
	self._numValue = 0
end

function ShortNumLabel:setNum(num, prefix, needJump)
	local text

	if type(num) == "number" then
		self._numValue = num
		text = ClientUtils.getNumShortStr(num)
	else
		text = num
	end

	if prefix then
		text = prefix .. text
	end

	self:setText(text, needJump)
end

function ShortNumLabel:setNumWithPrefix(v, prefix, needJump)
	return
end

function ShortNumLabel:getText()
	return self:getObj().text
end

function ShortNumLabel:getNum()
	return self._numValue
end

return ShortNumLabel
