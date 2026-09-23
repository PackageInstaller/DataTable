-- 天赋效果309802
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309802 = oo.class(SkillBase)
function Skill309802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill309802:OnActionBegin(caster, target, data)
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
	-- 309802
	self:AddBuff(SkillEffect[309802], caster, self.card, data, 4503)
end
-- 行动结束
function Skill309802:OnActionOver(caster, target, data)
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
	-- 309812
	self:DelBuff(SkillEffect[309812], caster, self.card, data, 4503,1)
end
