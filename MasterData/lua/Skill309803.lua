-- 天赋效果309803
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309803 = oo.class(SkillBase)
function Skill309803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill309803:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8100
	if SkillJudger:CompareAttr(self, caster, target, true,"speed") then
	else
		return
	end
	-- 309803
	self:AddBuff(SkillEffect[309803], caster, self.card, data, 4504)
end
-- 行动结束
function Skill309803:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8100
	if SkillJudger:CompareAttr(self, caster, target, true,"speed") then
	else
		return
	end
	-- 309813
	self:DelBuff(SkillEffect[309813], caster, self.card, data, 4504,1)
end
