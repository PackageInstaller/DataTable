-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301201308 = oo.class(SkillBase)
function Skill301201308:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill301201308:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11041], caster, target, data, 0.5,2)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11042], caster, target, data, 0.5,4)
end
-- 伤害前
function Skill301201308:OnBefourHurt(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	self:AddTempAttr(SkillEffect[999999989], caster, self.card, data, "damage",count7*0.006)
end
