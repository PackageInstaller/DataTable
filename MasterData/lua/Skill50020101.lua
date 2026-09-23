-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill50020101 = oo.class(SkillBase)
function Skill50020101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill50020101:OnAfterHurt(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	if self:Rand(3500) then
		self:AddBuff(SkillEffect[5007], caster, target, data, 5003)
	end
end
-- 执行技能
function Skill50020101:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
