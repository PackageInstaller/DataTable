-- 天赋效果310302
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310302 = oo.class(SkillBase)
function Skill310302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310302:OnActionBegin(caster, target, data)
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
	-- 8208
	if SkillJudger:IsCtrlType(self, caster, target, true,5) then
	else
		return
	end
	-- 310302
	self:AddBuff(SkillEffect[310302], caster, self.card, data, 4503)
end
-- 行动结束
function Skill310302:OnActionOver(caster, target, data)
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
	-- 8208
	if SkillJudger:IsCtrlType(self, caster, target, true,5) then
	else
		return
	end
	-- 310312
	self:DelBuff(SkillEffect[310312], caster, self.card, data, 4503,1)
end
