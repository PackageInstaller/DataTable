-- 黄金双子座技能5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950400501 = oo.class(SkillBase)
function Skill950400501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill950400501:DoSkill(caster, target, data)
	-- 11013
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11013], caster, target, data, 0.5,2)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 攻击结束
function Skill950400501:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8445
	local count45 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 950400501
	self:AddHp(SkillEffect[950400501], caster, target, data, -count45*0.25)
end
