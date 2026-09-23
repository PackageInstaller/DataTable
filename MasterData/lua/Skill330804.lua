-- 魁纣天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330804 = oo.class(SkillBase)
function Skill330804:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill330804:OnAttackBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8412
	local count12 = SkillApi:BuffCount(self, caster, target,2,1,2)
	-- 330806
	self:SetValue(SkillEffect[330806], caster, target, data, "sv1",count12)
end
-- 伤害前
function Skill330804:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8412
	local count12 = SkillApi:BuffCount(self, caster, target,2,1,2)
	-- 330807
	local sv1 = SkillApi:GetValue(self, caster, target,2,"sv1")
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
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8412
	local count12 = SkillApi:BuffCount(self, caster, target,2,1,2)
	-- 330807
	local sv1 = SkillApi:GetValue(self, caster, target,2,"sv1")
	-- 330804
	self:AddTempAttr(SkillEffect[330804], caster, self.card, data, "damage",0.2*(sv1-count12))
end
