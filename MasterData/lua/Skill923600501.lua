-- 世界树被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923600501 = oo.class(SkillBase)
function Skill923600501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill923600501:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 攻击结束
function Skill923600501:OnAttackOver(caster, target, data)
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
	-- 923600501
	self:AddBuffCount(SkillEffect[923600501], caster, self.card, data, 923600501,1,6)
end
-- 行动结束2
function Skill923600501:OnActionOver2(caster, target, data)
	-- 923600503
	local count923600501 = SkillApi:GetCount(self, caster, target,3,923600501)
	-- 923600504
	if SkillJudger:Greater(self, caster, target, true,count923600501,5) then
	else
		return
	end
	-- 923600502
	self:AddBuff(SkillEffect[923600502], caster, self.card, data, 923600502)
	-- 923600505
	self:DelBufferForce(SkillEffect[923600505], caster, self.card, data, 923600501,6)
end
