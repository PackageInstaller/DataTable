-- 灭刃阵营角色，每1000点攻击力，减少承受伤害1%，最多40%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100060052 = oo.class(SkillBase)
function Skill1100060052:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100060052:OnBefourHurt(caster, target, data)
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
	-- 8462
	local count62 = SkillApi:GetAttr(self, caster, target,3,"attack")
	-- 1100060052
	self:AddTempAttr(SkillEffect[1100060052], caster, self.card, data, "bedamage",math.max(-count62/100000,-0.4))
end
