-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tc_qie_cuo_chat.lua

module("logicconfig.config.t_tc_qie_cuo_chat", package.seeall)

local title = {
	chatId = 1,
	value = 2
}
local dataList = {
	{
		1,
		"来满公共养成对决"
	},
	{
		2,
		"就这…"
	},
	{
		3,
		"快点吧，等到花儿都谢了"
	},
	{
		4,
		"别怂，决战到天亮"
	},
	{
		5,
		"真正的菜鸟比高手难对付"
	},
	{
		6,
		"别走！加个好友"
	},
	{
		7,
		"再见了，我会想念你的"
	},
	{
		8,
		"大家好，很高兴见遇见你"
	}
}
local t_tc_qie_cuo_chat = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_tc_qie_cuo_chat.dataList = dataList

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

return t_tc_qie_cuo_chat
