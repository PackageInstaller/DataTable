-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saintknight_tian_teambuff.lua

module("logicconfig.config.t_saintknight_tian_teambuff", package.seeall)

local title = {
	selfBuff = 3,
	num = 2,
	buffPlanId = 1,
	des = 4
}
local dataList = {
	{
		1,
		0,
		"",
		"己阵全属性+<color=#20b376>0%</color>及生命上限+<color=#20b376>0%</color>"
	},
	{
		1,
		1,
		"20058303:99#20058304:99",
		"己阵全属性+<color=#20b376>10%</color>及生命上限+<color=#20b376>30%</color>"
	},
	{
		1,
		2,
		"5177:99#5176:99",
		"己阵全属性+<color=#20b376>20%</color>及生命上限+<color=#20b376>50%</color>"
	},
	{
		1,
		3,
		"20046809:99#20046810:99",
		"己阵全属性+<color=#20b376>40%</color>及生命上限+<color=#20b376>100%</color>"
	},
	{
		1,
		4,
		"20058309:99#20058310:99",
		"己阵全属性+<color=#20b376>300%</color>及生命上限+<color=#20b376>300%</color>"
	},
	{
		1,
		5,
		"20058311:99#20058312:99",
		"己阵全属性+<color=#20b376>500%</color>及生命上限+<color=#20b376>500%</color>"
	},
	{
		1,
		6,
		"20063507:99#20063508:99",
		"己阵全属性+<color=#20b376>700%</color>及生命上限+<color=#20b376>700%</color>"
	}
}
local t_saintknight_tian_teambuff = {
	{
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_saintknight_tian_teambuff.dataList = dataList

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

return t_saintknight_tian_teambuff
