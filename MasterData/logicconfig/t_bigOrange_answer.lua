-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bigOrange_answer.lua

module("logicconfig.config.t_bigOrange_answer", package.seeall)

local title = {
	answerTime = 5,
	questionTime = 2,
	question = 4,
	user = 3,
	id = 1,
	name = 6,
	answer = 7
}
local dataList = {
	{
		1,
		"2021-04-08",
		"热***奇",
		"后续还会有哪些精灵加入限时挑战吗？",
		"2021-04-10",
		"大橙子",
		"公测版本我们已经开放了阿瑞斯、潘多拉的限时挑战，未来还会陆续加入一些第一梯队的神宠，比如：赤焰龙皇，每个版本都会更新新的神宠，敬请期待吧~"
	},
	{
		2,
		"2021-04-10",
		"梦***玄",
		"手游里面还会有梦之队吗？",
		"2021-04-10",
		"大橙子",
		"梦之队是我们很重视的一批精灵，现在美术同学已经开始动笔绘画他们的形象啦，相信不久就能和大家见面了。稍稍剧透下：梦之队都是兽形态，并且将保留一直以来的福利定位，会有让大家惊喜的新玩法，可以期待一下。"
	},
	{
		3,
		"2021-05-21",
		"9***神",
		"希望能出一只单体伤害高的火系利爪",
		"2021-05-27",
		"大橙子",
		"我们最新登场的热血梦梦就是单体高爆发的火系利爪精灵，当然后续如果有合适的精灵的话，我们也会继续补充火系精灵的大家庭的"
	},
	{
		4,
		"2021-05-23",
		"文***清",
		"家族族长长时间不上线怎么办",
		"2021-05-27",
		"大橙子",
		"目前家族系统的族长转移等相关功能确实体验非常不好，目前对长期离线的族长、族长转移、还有踢人限制等体验问题我们已经在安排优化当中了，预计在后续版本的更新中实装，小奥奇可以留意我们的更新公告，如果计划有调整也会第一时间通过官方媒体的公告通知大家的。"
	},
	{
		5,
		"2021-05-25",
		"曜***师",
		"以后会有召唤师这个职业吗",
		"2021-05-27",
		"大橙子",
		"会有的，我们从内测开始就听到了许多玩家的呼声。召唤师是页游非常重要的一个精灵职业，但是由于召唤师，会对当前战斗体系造成比较大的影响，所以我们做这个决定也是慎之又慎，没能在开服的时候就上线召唤师职业。召唤师预期在今年内就能和大家见面了，大家可以期待一下"
	}
}
local t_bigOrange_answer = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_bigOrange_answer.dataList = dataList

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

return t_bigOrange_answer
