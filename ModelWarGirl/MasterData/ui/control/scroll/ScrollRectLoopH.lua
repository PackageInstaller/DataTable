-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Scroll\\ScrollRectLoopH.lua

local ScrollRectLoopV = require("UI/Control/Scroll/ScrollRectLoopV")
local UIConst = UIConst
local strClassName = "ScrollRectLoopH"
local ScrollRectLoopH = Class(strClassName, ScrollRectLoopV)

function ScrollRectLoopH:ctor(parent, path, totalCount, cellInitFunc)
	return
end

function ScrollRectLoopH:_getControlType()
	return UIConst.ControlTypeLoopScrollRectHorizontal
end

return ScrollRectLoopH
