-- 6.2版本机神被动2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914600501 = oo.class(SkillBase)
function Skill914600501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914600501:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
-- 伤害前
function Skill914600501:OnBefourHurt(caster, target, data)
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
	-- 9727
	local count816 = SkillApi:GetAttr(self, caster, target,1,"defense")
	-- 8459
	local count59 = SkillApi:GetAttr(self, caster, target,2,"defense")
	-- 914600501
	self:AddTempAttr(SkillEffect[914600501], caster, self.card, data, "bedamage2",math.min((count818-count59)*0.001,2))
end
