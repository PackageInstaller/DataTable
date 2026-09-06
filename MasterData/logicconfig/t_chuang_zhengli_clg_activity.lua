-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_zhengli_clg_activity.lua

module("logicconfig.config.t_chuang_zhengli_clg_activity", package.seeall)

local title = {
	lunhunDesc = 5,
	counterBuffId = 2,
	qijiDesc = 6,
	skinId = 3,
	paramStr = 4,
	activityId = 1
}
local dataList = {
	{
		398001,
		20058625,
		17022,
		"{\"jumpStr1\":\"func#618#17022\",\"jumpStr2\":\"mibao#shenyaomiya5\",\"jumpStr3\":\"func#1118\",\"jumpStr4\":\"func#545#52\"}",
		"每个大回合结束时，解除无法回血状态并恢复至满血满气势；在每次复活时，获得最大生命值80%的护盾",
		"每个大回合结束时，获得最大生命值上限*20%的生命护盾和20点气势"
	}
}
local t_chuang_zhengli_clg_activity = {
	[398001] = dataList[1]
}

t_chuang_zhengli_clg_activity.dataList = dataList

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

return t_chuang_zhengli_clg_activity
