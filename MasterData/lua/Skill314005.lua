-- 天赋效果314005
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill314005 = oo.class(SkillBase)
function Skill314005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill314005:OnAttackOver(caster, target, data)
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
	-- 314005
	self:AddProgress(SkillEffect[314005], caster, self.card, data, 500)
end
