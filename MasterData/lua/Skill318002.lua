-- 盾牌重压
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318002 = oo.class(SkillBase)
function Skill318002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill318002:OnBefourHurt(caster, target, data)
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
	-- 8423
	local count23 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 318002
	self:AddTempAttr(SkillEffect[318002], caster, self.card, data, "attack",count23*1.2)
end
