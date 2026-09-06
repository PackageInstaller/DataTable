-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_privilegemain.lua

module("logicconfig.config.t_privilegemain", package.seeall)

local title = {
	redpointId = 5,
	parameter = 6,
	viewname = 3,
	funcId = 4,
	id = 1,
	title = 2
}
local dataList = {
	{
		1,
		"周卡",
		"monthcardview",
		0,
		1,
		""
	},
	{
		2,
		"终身卡",
		"wholelifecardview",
		0,
		2,
		""
	},
	{
		3,
		"年费卡",
		"payshopyearview",
		118,
		46,
		""
	}
}
local t_privilegemain = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_privilegemain.dataList = dataList

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

return t_privilegemain
