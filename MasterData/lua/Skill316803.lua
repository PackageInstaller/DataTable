-- 融会
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill316803 = oo.class(SkillBase)
function Skill316803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill316803:OnActionBegin(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 316803
	self:AddBuff(SkillEffect[316803], caster, self.card, data, 4304,1)
end
