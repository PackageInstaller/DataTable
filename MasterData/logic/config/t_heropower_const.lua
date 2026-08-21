-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_heropower_const.lua

module("logic.config.t_heropower_const", package.seeall)

local title = {
	strValue = 2,
	keyName = 1,
	numValue = 3
}
local dataList = {
	{
		"upgrade_record_text_1",
		"药剂名称：log基因强化液\r\n注射部位：颈静脉\r\n注射单位：泛星海亲和度中心\r\n附注：目标注射后半小时内出现短暂的头晕、呼吸困难及心跳加速，于症状缓解后离院。",
		0
	},
	{
		"upgrade_record_text_2",
		"药剂名称：log基因强化液\r\n注射部位：颈静脉\r\n注射单位：泛星海亲和度中心\r\n附注：目标注射一小时后出现严重过敏反应，含面部和喉咙肿胀、呕吐、发热、心悸等症状，留院治疗恢复后离院。",
		0
	},
	{
		"upgrade_record_text_3",
		"药剂名称：log基因强化液\r\n注射部位：颈静脉\r\n注射单位：泛星海亲和度中心\r\n附注：目标注射后出现过敏性休克，留院治疗恢复后离院。",
		0
	},
	{
		"upgrade_record_text_4",
		"药剂名称：log基因强化液加强剂\r\n注射部位：颈静脉\r\n注射单位：亲和度与药物研究所\r\n附注：据目标所述，注射加强剂后曾陷入长达18小时昏迷，期间没有任何记忆。",
		0
	}
}
local t_heropower_const = {}

t_heropower_const.dataList = dataList

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
	t_heropower_const[v[1]] = v

	setmetatable(v, mt)
end

return t_heropower_const
