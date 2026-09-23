-- 双子宫-波拉克斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984010701 = oo.class(SkillBase)
function Skill984010701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill984010701:OnAttackOver(caster, target, data)
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
	-- 8145
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 984010502
	self:AddProgress(SkillEffect[984010502], caster, self.card, data, 250)
end
