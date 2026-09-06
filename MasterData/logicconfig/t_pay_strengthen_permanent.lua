-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_strengthen_permanent.lua

module("logicconfig.config.t_pay_strengthen_permanent", package.seeall)

local title = {
	showPrice = 3,
	payType = 2,
	payGoodsId = 4,
	type = 1,
	param = 5
}
local dataList = {
	{
		1,
		2,
		"204:110001:480",
		"204:110001:178",
		""
	},
	{
		2,
		2,
		"204:110002:180",
		"204:110002:118",
		""
	},
	{
		3,
		2,
		"204:110003:380",
		"204:110003:178",
		""
	},
	{
		4,
		2,
		"204:110004:880",
		"204:110004:448",
		""
	},
	{
		5,
		2,
		"204:110005:1580",
		"204:110005:588",
		""
	},
	{
		6,
		2,
		"204:110006:780",
		"204:110006:448",
		""
	},
	{
		7,
		2,
		"",
		"204:110001:180",
		""
	},
	{
		8,
		2,
		"",
		"204:110001:180",
		""
	},
	{
		9,
		2,
		"",
		"204:110001:180",
		""
	}
}
local t_pay_strengthen_permanent = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_pay_strengthen_permanent.dataList = dataList

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

return t_pay_strengthen_permanent
