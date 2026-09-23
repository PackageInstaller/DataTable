-- 天赋效果314002
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill314002 = oo.class(SkillBase)
function Skill314002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill314002:OnAttackOver(caster, target, data)
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
	-- 314002
	self:AddProgress(SkillEffect[314002], caster, self.card, data, 200)
end
