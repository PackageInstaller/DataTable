-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_survey.lua

module("logic.config.t_survey", package.seeall)

local title = {
	id = 1,
	title = 2,
	rewardMail = 3,
	desc = 4
}
local dataList = {
	{
		1,
		"《时序残响》调查问卷",
		2001,
		"本次体验计划已临近尾声，非常感谢各位主管的参与，以下是针对本次体验计划的行动复盘，期待主管的填写反馈"
	},
	{
		99,
		"备份示例问卷",
		1001,
		"非常感谢..."
	}
}
local t_survey = {}

t_survey.dataList = dataList

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
	t_survey[v[1]] = v

	setmetatable(v, mt)
end

return t_survey
