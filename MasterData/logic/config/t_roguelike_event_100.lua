-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_event_100.lua

module("logic.config.t_roguelike_event_100", package.seeall)

local title = {
	description = 5,
	name = 4,
	type = 3,
	repetitionLimit = 8,
	condition = 10,
	prestory = 11,
	scriptId = 1,
	illustration = 6,
	replys = 12,
	mark = 13,
	id = 2,
	weight = 9,
	layer = 7
}
local dataList = {
	{
		100,
		100999,
		5,
		"迷雾世界",
		"迷雾阻挡了前行的路，灵感告诉你此刻有个意愿在抵触你的前行。",
		"sj_zhuxian01",
		1,
		1,
		0,
		0,
		"0",
		{
			10099901
		},
		""
	},
	{
		100,
		1000000,
		7,
		"林中篝火",
		"空气中的暖意吸引你走到了一片篝火前，这里没有人，只有熊熊燃烧的火焰和一个黑色的包裹。包裹内三明治能为你补充体力，胡萝卜汁能为你恢复理智，皮夹子中有一些零碎的金币。",
		"sj_xiansuo01",
		1,
		0,
		0,
		0,
		"0",
		{
			10000001,
			10000002,
			10000003,
			10000004
		},
		""
	},
	{
		100,
		1000101,
		3,
		"灰霾",
		"这是一座被灰霾包围的城市，你环顾四周，发现能看清的东西只有路灯下的自己。\r\n大路的左方有一小片方形的光影，你推断那是一片居民楼。若能找到人交谈，对于了解迷雾大陆来说是再好不过的事。",
		"sj_kongbai",
		1,
		0,
		0,
		0,
		"0",
		{
			10001011
		},
		""
	},
	{
		100,
		1000102,
		3,
		"夜里的歌声",
		"你顺着大路走到一座老式别墅前，判断没有出错，你喜形于色。更令人感到惊喜的是门后传来了断断续续的哼唱：\r\n“▊▊，▊▊，你来自哪里？”\r\n“我来自遥远的▊▊▊，一片森林里。”",
		"sj_zhuxian01",
		1,
		0,
		0,
		0,
		"0",
		{
			10001021,
			10001022
		},
		""
	},
	{
		100,
		1000103,
		3,
		"黑压压的影子",
		"一片黑压压的影子在雾中十分诡异，起风了，风吹过影子，你听到了一片唰唰唰的声音。原来前方是一片树林，你不禁松了一口气。",
		"sj_kongbai",
		1,
		0,
		0,
		0,
		"0",
		{
			10001031
		},
		""
	},
	{
		100,
		1000104,
		10,
		"鬼火？",
		"森林中出现了幽蓝的灯光，时影时现，仿若传闻中的鬼火。你提起十二分警惕，继续向前摸索。",
		"sj_zhandou01",
		1,
		0,
		0,
		0,
		"0",
		{
			10001041
		},
		""
	},
	{
		100,
		1000105,
		3,
		"漂亮的镜子",
		"树下突兀放置了一块圆角的全身镜，你凑近观察，发现镜框处还贴有蝴蝶结和彩带装饰。或许是折射原理，镜子淡淡发着微光，似乎正在召唤你上前。",
		"sj_zhuxian01",
		1,
		0,
		0,
		0,
		"0",
		{
			10001051,
			10001052
		},
		""
	},
	{
		100,
		1000106,
		3,
		"月光与秋千",
		"哼唱声从道路前方传来，月亮不知道什么时候变得无比明亮，你借着月光看到秋千上有个女孩晃悠的身影。\r\n“我来自▊▊▊▊，一个庄园里。”\r\n“我有一座大洋房，里面堆满了蝴蝶结和洋娃娃……”",
		"sj_zhixian01_start",
		1,
		0,
		0,
		0,
		"0",
		{
			10001061,
			10001062
		},
		""
	},
	{
		100,
		1000107,
		10,
		"赤红的眼睛",
		"一个硕大的影子拦住了你的去路，迷路的你似乎闯入了威胁的地方。你听到属于野兽的喘息声环绕在你身边，你看到一双又一双赤红的眼睛在森林中亮起。",
		"sj_zhuxian01_guiyi",
		1,
		0,
		0,
		0,
		"0",
		{
			10001071
		},
		""
	},
	{
		100,
		1000108,
		3,
		"远处的歌谣",
		"雾气紊乱，随着嚎叫声消失，围绕在湖心的薄雾也渐渐消散。你听到了遥远的地方传来了稚嫩的童谣，似乎是从月亮上传来的，又似乎来自遥远的过去。",
		"sj_siwang",
		1,
		0,
		0,
		0,
		"5000101",
		{
			10001081
		},
		""
	}
}
local t_roguelike_event_100 = {}

t_roguelike_event_100.dataList = dataList

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
	local parent1 = t_roguelike_event_100[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_roguelike_event_100[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_roguelike_event_100
