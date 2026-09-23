-- 信风4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill400201302 = oo.class(SkillBase)
function Skill400201302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill400201302:DoSkill(caster, target, data)
	-- 12026
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12026], caster, target, data, 0.2,4)
	-- 12027
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12027], caster, target, data, 0.2,1)
end
-- 伤害前
function Skill400201302:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 999999989
	self:AddTempAttr(SkillEffect[999999989], caster, self.card, data, "damage",count7*0.006)
end
