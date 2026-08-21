-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_survey_subject.lua

module("logic.config.t_survey_subject", package.seeall)

local title = {
	surverId = 1,
	preSelection = 4,
	query = 5,
	type = 3,
	subjectId = 2,
	selectRange = 7,
	desc = 6
}
local dataList = {
	{
		99,
		1,
		1,
		nil,
		"单选题",
		"[跑团|bg_scene_2],[战斗],[其他|]",
		{
			3
		}
	},
	{
		99,
		2,
		2,
		nil,
		"下拉单选题",
		"[1950|2010]",
		{
			1950,
			2010
		}
	},
	{
		99,
		3,
		3,
		{
			1,
			0
		},
		"复选题",
		"[跑团|bg_scene_2],[战斗],[其他|]",
		{
			3
		}
	},
	{
		99,
		4,
		4,
		nil,
		"矩阵单选题",
		"[战斗|$bg_scene_1|剧情|$bg_scene_2],[满意|比较满意|一般|不太满意|非常不满意]",
		{
			4,
			5
		}
	},
	{
		99,
		5,
		5,
		nil,
		"简答题",
		""
	},
	{
		99,
		6,
		6,
		nil,
		"星级题",
		"[战斗|$bg_scene_1|剧情|$bg_scene_2]",
		{
			4,
			5
		}
	},
	{
		1,
		1,
		2,
		nil,
		"[单选]请选择主管的年龄",
		"[小于15岁|15~20岁|21~25岁|26~30岁|31~35岁|35~40岁|40岁以上]",
		{
			0,
			6
		}
	},
	{
		1,
		2,
		1,
		nil,
		"[单选]请选择主管的性别",
		"[男],[女]",
		{
			2
		}
	},
	{
		1,
		3,
		5,
		nil,
		"[简答]请填写主管的手机型号",
		""
	},
	{
		1,
		4,
		6,
		nil,
		"[单选]请主管对本次体验版本的游玩感受进行评分（5星表示最高分）",
		"[评分]",
		{
			1,
			5
		}
	},
	{
		1,
		5,
		6,
		nil,
		"[单选]请主管对本次体验版本的剧情内容进行评分（5星表示最高分）",
		"[评分]",
		{
			1,
			5
		}
	},
	{
		1,
		6,
		6,
		nil,
		"[矩阵单选]请主管对本次体验版本的美术模块进行评分（5星表示最高分）",
		"[角色立绘|角色建模|动作表现|UI界面]",
		{
			4,
			5
		}
	},
	{
		1,
		7,
		6,
		nil,
		"[单选]请主管对本次体验版本的战斗模块进行评分（5星表示最高分）",
		"[评分]",
		{
			1,
			5
		}
	},
	{
		1,
		8,
		6,
		nil,
		"[单选]请问主管对本次体验版本战斗难度进行评分（星数越高表示难度越大）",
		"[评分]",
		{
			1,
			5
		}
	},
	{
		1,
		9,
		3,
		nil,
		"[多选]请问以下哪一部分战斗机制让主管觉得复杂或困惑",
		"[理智强化（技能强化）|op_1_9_1],[弱点机制（校正）|op_1_9_2],[属性克制|op_1_9_3],[战斗操作|op_1_9_4],[其他|]",
		{
			5
		}
	},
	{
		1,
		10,
		1,
		nil,
		"[单选]请主管是否能通过新手引导了解游戏操作规则",
		"[是],[否]",
		{
			2
		}
	},
	{
		1,
		11,
		6,
		nil,
		"[矩阵单选]请主管对以下各项玩法进行评价",
		"[主线战斗$op_1_11_1|安定区域$op_1_11_2|红雾区域$op_1_11_3|梦境档案室$op_1_11_4]",
		{
			4,
			5
		}
	},
	{
		1,
		12,
		1,
		nil,
		"[单选]请问主管对是否理解[梦境档案室]玩法",
		"[是],[否]",
		{
			2
		}
	},
	{
		1,
		13,
		6,
		nil,
		"[矩阵单选]请主管对以下角色养成系统进行评价",
		"[残响$op_1_13_1|校时器$op_1_13_2|亲和度$op_1_13_3]",
		{
			3,
			5
		}
	},
	{
		1,
		14,
		1,
		nil,
		"[单选]请问主管进行游戏时是否流畅",
		"[流畅运行],[偶尔卡顿],[频繁卡顿],[其他|]",
		{
			4
		}
	},
	{
		1,
		15,
		1,
		nil,
		"[单选]是否愿意将游戏推荐给朋友",
		"[是],[否]",
		{
			2
		}
	},
	{
		1,
		16,
		5,
		nil,
		"[简答]请问对本次体验版本是否有其他建议或不满，可以在此处留言告诉我们。",
		""
	}
}
local t_survey_subject = {}

t_survey_subject.dataList = dataList

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
	local parent1 = t_survey_subject[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_survey_subject[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_survey_subject
