-- 凶蛮意志
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill319402 = oo.class(SkillBase)
function Skill319402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill319402:OnBefourHurt(caster, target, data)
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
	-- 8488
	local count88 = SkillApi:GetCount(self, caster, target,3,302200201)
	-- 8179
	if SkillJudger:Greater(self, caster, target, true,count88,0) then
	else
		return
	end
	-- 8462
	local count62 = SkillApi:GetAttr(self, caster, target,3,"attack")
	-- 319402
	self:AddTempAttr(SkillEffect[319402], caster, self.card, data, "bedamage",math.max(-count62/45000,-0.4))
end
