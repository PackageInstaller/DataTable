-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guard_destroy_sign_in_buff.lua

module("logicconfig.config.t_guard_destroy_sign_in_buff", package.seeall)

local title = {
	desc = 3,
	signInPlanId = 1,
	level = 2
}
local dataList = {
	{
		1,
		1,
		"除助战精灵外己阵全属性及生命上限+10%"
	},
	{
		1,
		2,
		"除助战精灵外己阵全属性及生命上限+30%"
	},
	{
		1,
		3,
		"除助战精灵外己阵全属性及生命上限+80%"
	},
	{
		1,
		4,
		"除助战精灵外己阵全属性及生命上限+200%"
	},
	{
		1,
		5,
		"除助战精灵外己阵全属性及生命上限+400%"
	},
	{
		1,
		6,
		"除助战精灵外己阵全属性及生命上限+600%"
	},
	{
		1,
		7,
		"除助战精灵外己阵全属性及生命上限+1000%"
	},
	{
		1,
		8,
		"除助战精灵外己阵全属性及生命上限+1500%"
	},
	{
		2,
		1,
		"己阵全属性及生命上限+30%"
	},
	{
		2,
		2,
		"己阵全属性及生命上限+80%"
	},
	{
		2,
		3,
		"己阵全属性及生命上限+200%"
	},
	{
		2,
		4,
		"己阵全属性及生命上限+600%"
	},
	{
		2,
		5,
		"己阵全属性及生命上限+1000%"
	},
	{
		2,
		6,
		"己阵全属性及生命上限+1500%"
	}
}
local t_guard_destroy_sign_in_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_guard_destroy_sign_in_buff.dataList = dataList

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

return t_guard_destroy_sign_in_buff
