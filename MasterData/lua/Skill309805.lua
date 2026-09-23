-- 天赋效果309805
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309805 = oo.class(SkillBase)
function Skill309805:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill309805:OnActionBegin(caster, target, data)
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
	-- 309805
	self:AddBuff(SkillEffect[309805], caster, self.card, data, 4506)
end
-- 行动结束
function Skill309805:OnActionOver(caster, target, data)
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
	-- 309815
	self:DelBuff(SkillEffect[309815], caster, self.card, data, 4506,1)
end
