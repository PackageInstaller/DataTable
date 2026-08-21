-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\RateEffectPlayer.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local strClassName = "RateEffectPlayer"
local RateEffectPlayer = Class(strClassName, UIBaseControl)

function RateEffectPlayer:ctor(parent, path)
	return
end

function RateEffectPlayer:_getControlType()
	return UIConst.ControlTypeRateEffectPlayer
end

function RateEffectPlayer:setRate(targetValue, costTime)
	local obj = self:getComObj()

	if obj then
		obj:SetRate(targetValue, costTime, "_Percent")
	end
end

return RateEffectPlayer
