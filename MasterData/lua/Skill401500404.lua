-- 光学反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401500404 = oo.class(SkillBase)
function Skill401500404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401500404:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	-- 401500404
	self.order = self.order + 1
	self:AddBuff(SkillEffect[401500404], caster, target, data, 401500404)
	-- 4401517
	local c618 = SkillApi:GetValue(self, caster, self.card,3,"c618")
	-- 4401514
	self.order = self.order + 1
	self:AddHp(SkillEffect[4401514], caster, target, data, math.floor(-c618*0.9))
	-- 8619
	local count619 = SkillApi:SkillLevel(self, caster, target,3,3250)
	-- 4401519
	self.order = self.order + 1
	self:AddHp(SkillEffect[4401519], caster, self.card, data, math.floor(c618*count619*0.15))
	-- 4401518
	self.order = self.order + 1
	self:SetValue(SkillEffect[4401518], caster, self.card, data, "c618",0)
end
