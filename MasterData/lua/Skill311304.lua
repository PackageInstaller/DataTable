-- 吸收盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311304 = oo.class(SkillBase)
function Skill311304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill311304:OnActionOver(caster, target, data)
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
	-- 311304
	self:AddBuff(SkillEffect[311304], caster, self.card, data, 2405)
end
