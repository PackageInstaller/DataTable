-- 暴虐乐团被动4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980101201 = oo.class(SkillBase)
function Skill980101201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill980101201:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980101201
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[980101201], caster, target, data, 980101201)
	end
end
-- 行动结束
function Skill980101201:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 9714
	local count803 = SkillApi:ClassCount(self, caster, target,1,2)
	-- 8231
	if SkillJudger:IsCasterMech(self, caster, self.card, true,2) then
	else
		return
	end
	-- 980101202
	local targets = SkillFilter:Group(self, caster, target, 4,2)
	for i,target in ipairs(targets) do
		self:AddNp(SkillEffect[980101202], caster, target, data, 5)
	end
end
