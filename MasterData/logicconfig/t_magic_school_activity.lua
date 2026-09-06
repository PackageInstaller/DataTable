-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_activity.lua

module("logicconfig.config.t_magic_school_activity", package.seeall)

local title = {
	ruleRenZheng = 7,
	activitySummaryId = 5,
	blackCampDesc = 10,
	fakeProgressRedPointId = 11,
	zdlPlanId = 2,
	whiteCampDesc = 9,
	activityProgressId = 8,
	changeCampDays = 3,
	progressActivityItemId = 4,
	activityId = 1,
	ruleKey = 6
}
local dataList = {
	{
		514001,
		1,
		8,
		"514001",
		31025,
		"magicschoollist_rule",
		"1、见习认证为线性关卡，需按顺序通关；\n2、破阵时，可以选择阵营能力带入，可通过提升魔法等级获得更多；\n3、关卡均使用系统精灵挑战；\n4、次周更换阵营时，可挑战另一阵营的见习关卡，两个阵营关卡的通关条件不同。",
		262007,
		"【白魔法能力】\n①.进入战斗时获得最大生命值上限*15%的生命护盾\n②.受击时，获得最大生命值上限*8%的生命护盾\n③.使用治疗技能时，为受疗单位附加治疗量10%的护盾\n④.受击时，获得最大生命值上限*12%的生命护盾\n⑤.使用治疗技能时，为受疗单位附加治疗量20%的护盾\n⑥.受到的治疗效果+50%\n⑦.最大生命上限+100%",
		"【黑魔法能力】\n①.进入战斗时获得50气势\n②.暴击率+20%\n③.攻击时，降低目标50%受疗效果\n④.暴击伤害+50%\n⑤.攻击时，使目标获得30%受伤加深\n⑥.攻击时，吸收目标30气势\n⑦.攻击力+80%",
		472
	}
}
local t_magic_school_activity = {
	[514001] = dataList[1]
}

t_magic_school_activity.dataList = dataList

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

return t_magic_school_activity
