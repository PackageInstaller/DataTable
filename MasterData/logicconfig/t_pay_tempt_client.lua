-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_tempt_client.lua

module("logicconfig.config.t_pay_tempt_client", package.seeall)

local title = {
	shopId = 2,
	slogantype = 4,
	imgIdx = 7,
	openTime = 3,
	id = 1,
	rebate = 6,
	sloganImg = 5,
	hudImgIdx = 8
}
local dataList = {
	{
		1,
		1004,
		"2018-1-1 09:00:00#2018-1-1 23:00:00",
		0,
		"",
		1500,
		1,
		0
	}
}
local t_pay_tempt_client = {
	dataList[1]
}

t_pay_tempt_client.dataList = dataList

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

return t_pay_tempt_client
