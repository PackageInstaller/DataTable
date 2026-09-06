-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_petskin_common_config.lua

module("logicconfig.config.t_petskin_common_config", package.seeall)

local title = {
	value = 2,
	key = 1,
	desc = 3
}
local dataList = {
	{
		"TIPS_1",
		"",
		"使用后限时皮肤开始倒计时，可使用多张时间叠加，是否确定使用？"
	},
	{
		"TIPS_2",
		"",
		"已拥有【%s】,是否把该皮肤转化成%s个皮肤劵？"
	},
	{
		"TIPS_3",
		"",
		"因未拥有精灵【%s】无法使用【%s】"
	},
	{
		"TIPS_4",
		"",
		"永久皮肤多个使用时，仅1个生效，每超过1个将转换成%s个皮肤劵，是否确定使用？"
	},
	{
		"TIPS_5",
		"",
		"当前有正使用的限时皮肤，使用后将直接变成永久皮肤，多个使用时，仅1个生效，每超过1个将转换成%s个皮肤劵，是否确定使用？"
	},
	{
		"DAYS_TO_REFUND",
		"8:17:1",
		"体验卡天数转化为皮肤币个数"
	},
	{
		"FOREVER_TO_REFUND",
		"8:17:50",
		"永久皮肤转化皮肤币个数"
	}
}
local t_petskin_common_config = {
	TIPS_1 = dataList[1],
	TIPS_2 = dataList[2],
	TIPS_3 = dataList[3],
	TIPS_4 = dataList[4],
	TIPS_5 = dataList[5],
	DAYS_TO_REFUND = dataList[6],
	FOREVER_TO_REFUND = dataList[7]
}

t_petskin_common_config.dataList = dataList

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

return t_petskin_common_config
