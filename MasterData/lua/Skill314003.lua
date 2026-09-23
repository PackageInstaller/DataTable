-- 天赋效果314003
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill314003 = oo.class(SkillBase)
function Skill314003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill314003:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8158
	if SkillJudger:IsMinProgress(self, caster, self.card, true) then
	else
		return
	end
	-- 314003
	self:AddProgress(SkillEffect[314003], caster, self.card, data, 300)
end
