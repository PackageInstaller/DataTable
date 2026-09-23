-- 天赋效果311803
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311803 = oo.class(SkillBase)
function Skill311803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill311803:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 311803
	if self:Rand(4000) then
		self:AddProgress(SkillEffect[311803], caster, self.card, data, 200)
	end
end
