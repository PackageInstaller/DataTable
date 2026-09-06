-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kindergarten_common.lua

module("logicconfig.config.t_kindergarten_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"JOB_NAME1",
		"体育特长"
	},
	{
		"JOB_NAME2",
		"艺术特长"
	},
	{
		"JOB_NAME3",
		"智力特长"
	},
	{
		"JOB_NAME4",
		"全面发展"
	},
	{
		"JOB_NAME5",
		"标新立异"
	}
}
local t_kindergarten_common = {
	JOB_NAME1 = dataList[1],
	JOB_NAME2 = dataList[2],
	JOB_NAME3 = dataList[3],
	JOB_NAME4 = dataList[4],
	JOB_NAME5 = dataList[5]
}

t_kindergarten_common.dataList = dataList

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

return t_kindergarten_common
