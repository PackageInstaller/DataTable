-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_server_pet_gain_buff.lua

module("logicconfig.config.t_time_server_pet_gain_buff", package.seeall)

local title = {
	buffPlanId = 1,
	value = 2
}
local dataList = {
	{
		1,
		"<color=#C54949>6月17号至7月1号</color>活动期间赤焰龙皇祝福限时生效。针对所有玩法上阵<color=#C54949>赤焰龙皇</color>（包括穿戴皮肤），该精灵有暴击率+35%、生命+20%的增益效果。"
	}
}
local t_time_server_pet_gain_buff = {
	dataList[1]
}

t_time_server_pet_gain_buff.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_time_server_pet_gain_buff
