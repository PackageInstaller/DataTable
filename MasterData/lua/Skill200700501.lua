-- 全体圣愈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200700501 = oo.class(SkillBase)
function Skill200700501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200700501:DoSkill(caster, target, data)
	-- 8469
	local count69 = SkillApi:GetEnergy(self, caster, target,3)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8611
	local count611 = SkillApi:SkillLevel(self, caster, target,3,3239)
	-- 8613
	local count613 = SkillApi:GetAttr(self, caster, target,3,"cure")
	-- 4200711
	self.order = self.order + 1
	self:AddHp(SkillEffect[4200711], caster, target, data, count69/count76*0.2*count611*count613)
end
-- 行动结束
function Skill200700501:OnActionOver(caster, target, data)
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
	-- 4200716
	self:SetValue(SkillEffect[4200716], caster, self.card, data, "energy",10)
end
