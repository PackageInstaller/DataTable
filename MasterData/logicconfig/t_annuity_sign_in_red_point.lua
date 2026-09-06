-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_sign_in_red_point.lua

module("logicconfig.config.t_annuity_sign_in_red_point", package.seeall)

local title = {
	actId = 1,
	redPointId = 2
}
local dataList = {
	{
		8002,
		188
	},
	{
		8003,
		439
	},
	{
		8004,
		542
	},
	{
		8005,
		439
	},
	{
		8006,
		542
	}
}
local t_annuity_sign_in_red_point = {
	[8002] = dataList[1],
	[8003] = dataList[2],
	[8004] = dataList[3],
	[8005] = dataList[4],
	[8006] = dataList[5]
}

t_annuity_sign_in_red_point.dataList = dataList

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

return t_annuity_sign_in_red_point
