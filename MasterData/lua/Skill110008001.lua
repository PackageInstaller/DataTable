-- 耐久低于60%，防御增加20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008001 = oo.class(SkillBase)
function Skill110008001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill110008001:OnAfterHurt(caster, target, data)
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
	-- 8146
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.6) then
	else
		return
	end
	-- 110008001
	self:AddUplimitBuff(SkillEffect[110008001], caster, self.card, data, 3,3,4104,1,4104)
end
