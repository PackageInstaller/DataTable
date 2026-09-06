-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qixi_send_gift_item.lua

module("logicconfig.config.t_qixi_send_gift_item", package.seeall)

local title = {
	itemKey = 3,
	sugar = 5,
	romance = 6,
	effPath = 7,
	id = 2,
	showEffect = 8,
	sendPrize = 4,
	itemPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"4:510141",
		"",
		10,
		10,
		"20230210/qixizengli/fx_ui_qixizengli_hua2",
		true
	},
	{
		1,
		2,
		"4:510142",
		"",
		50,
		50,
		"20230210/qixizengli/fx_ui_qixizengli_hua1",
		true
	},
	{
		2,
		1,
		"4:510213",
		"",
		10,
		10,
		"20230210/qixizengli/fx_ui_qixizengli_hua2",
		true
	},
	{
		2,
		2,
		"4:510212",
		"",
		50,
		50,
		"20230210/qixizengli/fx_ui_qixizengli_hua1",
		true
	}
}
local t_qixi_send_gift_item = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	}
}

t_qixi_send_gift_item.dataList = dataList

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

return t_qixi_send_gift_item
