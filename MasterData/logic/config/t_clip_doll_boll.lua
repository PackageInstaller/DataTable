-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_clip_doll_boll.lua

module("logic.config.t_clip_doll_boll", package.seeall)

local title = {
	imageFirst = 2,
	id = 1,
	imageSecond = 3,
	model = 4
}
local dataList = {
	{
		1,
		"prize_claw/prize_claw_dynamic/gashapon_c_01",
		"prize_claw/prize_claw_dynamic/gashapon_c_02",
		"bolls_orange_trigger"
	},
	{
		2,
		"prize_claw/prize_claw_dynamic/gashapon_b_01",
		"prize_claw/prize_claw_dynamic/gashapon_b_02",
		"bolls_blue_trigger"
	},
	{
		3,
		"prize_claw/prize_claw_dynamic/gashapon_d_01",
		"prize_claw/prize_claw_dynamic/gashapon_d_02",
		"bolls_green_trigger"
	}
}
local t_clip_doll_boll = {}

t_clip_doll_boll.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_clip_doll_boll[v[1]] = v

	setmetatable(v, mt)
end

return t_clip_doll_boll
