-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Entity\\EmptyProp.lua

local strClassName = "EmptyProp"
local EmptyProp = Class(strClassName)

function EmptyProp:ctor(master)
	self.master = master
end

function EmptyProp:getProp(propName, defaultValue)
	if self.props then
		return self.props[propName] or defaultValue
	else
		return defaultValue
	end
end

return EmptyProp
