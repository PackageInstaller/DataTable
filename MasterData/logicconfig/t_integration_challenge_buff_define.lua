-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_integration_challenge_buff_define.lua

module("logicconfig.config.t_integration_challenge_buff_define", package.seeall)

local title = {
	selfBuff = 3,
	desc = 4,
	buffPlanId = 1,
	level = 2
}
local dataList = {
	{
		1,
		1,
		"50042:99#50072:99",
		"LV.<color=#20b376>1</color>，己阵全属性+<color=#20b376>10%</color>"
	},
	{
		1,
		2,
		"50043:99#50073:99",
		"LV.<color=#20b376>2</color>，己阵全属性+<color=#20b376>20%</color>"
	},
	{
		1,
		3,
		"50044:99#50074:99",
		"LV.<color=#20b376>3</color>，己阵全属性+<color=#20b376>30%</color>"
	},
	{
		1,
		4,
		"50045:99#50075:99",
		"LV.<color=#20b376>4</color>，己阵全属性+<color=#20b376>40%</color>"
	},
	{
		1,
		5,
		"50046:99#50076:99",
		"LV.<color=#20b376>5</color>，己阵全属性+<color=#20b376>50%</color>"
	},
	{
		1,
		6,
		"50047:99#50077:99",
		"LV.<color=#20b376>6</color>，己阵全属性+<color=#20b376>60%</color>"
	},
	{
		1,
		7,
		"50048:99#50078:99",
		"LV.<color=#20b376>7</color>，己阵全属性+<color=#20b376>70%</color>"
	},
	{
		1,
		8,
		"50049:99#50079:99",
		"LV.<color=#20b376>8</color>，己阵全属性+<color=#20b376>80%</color>"
	},
	{
		1,
		9,
		"50050:99#50080:99",
		"LV.<color=#20b376>9</color>，己阵全属性+<color=#20b376>90%</color>"
	},
	{
		1,
		10,
		"50051:99#50081:99",
		"LV.<color=#20b376>10</color>，己阵全属性+<color=#20b376>100%</color>"
	},
	{
		1,
		11,
		"50052:99#50082:99",
		"LV.<color=#20b376>11</color>，己阵全属性+<color=#20b376>110%</color>"
	},
	{
		1,
		12,
		"50053:99#50083:99",
		"LV.<color=#20b376>12</color>，己阵全属性+<color=#20b376>120%</color>"
	},
	{
		1,
		13,
		"50054:99#50084:99",
		"LV.<color=#20b376>13</color>，己阵全属性+<color=#20b376>130%</color>"
	},
	{
		1,
		14,
		"50055:99#50085:99",
		"LV.<color=#20b376>14</color>，己阵全属性+<color=#20b376>140%</color>"
	},
	{
		1,
		15,
		"50056:99#50086:99",
		"LV.<color=#20b376>15</color>，己阵全属性+<color=#20b376>150%</color>"
	}
}
local t_integration_challenge_buff_define = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_integration_challenge_buff_define.dataList = dataList

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

return t_integration_challenge_buff_define
