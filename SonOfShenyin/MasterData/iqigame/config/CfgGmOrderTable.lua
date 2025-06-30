-- chunkname: @IQIGame\\Config\\CfgGmOrderTable.lua

local CfgGmOrderTable = {
	{
		ParamNum = 1,
		Name = "全部道具",
		Describe = "数量",
		Id = 1,
		Order = "/cmd addallitem"
	},
	{
		ParamNum = 2,
		Name = "单个道具",
		Describe = "道具id 道具数量",
		Id = 2,
		Order = "/cmd additem"
	},
	{
		Id = 3,
		Name = "清除引导",
		Order = "/cmd clearGuide"
	},
	{
		Id = 4,
		Name = "带附件邮件",
		Order = "/cmd sendmail"
	},
	{
		Id = 5,
		Name = "不带附件邮件",
		Order = "/cmd sendNoMail"
	},
	{
		ParamNum = 2,
		Name = "使用道具",
		Describe = "道具id 道具数量",
		Id = 6,
		Order = "/cmd useItem"
	},
	{
		ParamNum = 3,
		Name = "完成指定章节副本",
		Describe = "副本类型(1剧情2日常3装备4boss)  章节id 关卡id",
		Id = 7,
		Order = "/cmd finishDup"
	},
	{
		ParamNum = 2,
		Name = "抽卡模拟",
		Describe = "卡池id   模拟次数",
		Id = 8,
		Order = "/cnd draw"
	},
	{
		ParamNum = 2,
		Name = "完成指定章节",
		Describe = "副本类型(1爬塔2日常3装备4boss5剧情)   章节id",
		Id = 9,
		Order = "/cmd finishChapter"
	},
	{
		ParamNum = 1,
		Name = "完成指定主线关卡",
		Describe = "关卡id",
		Id = 10,
		Order = "/cmd finishMain"
	},
	{
		ParamNum = 1,
		Name = "升星指定的英雄",
		Describe = "角色id",
		Id = 11,
		Order = "/cmd heroStar"
	}
}

setmetatable(CfgGmOrderTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGmOrderTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ParamNum = 0,
		Describe = "",
		Order = "",
		Name = ""
	}
}

for i, data in pairs(CfgGmOrderTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGmOrderTable
