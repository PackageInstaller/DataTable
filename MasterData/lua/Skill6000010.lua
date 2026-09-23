-- 连锁阵线第二期buff3（短轴）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000010 = oo.class(SkillBase)
function Skill6000010:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill6000010:OnBefourHurt(caster, target, data)
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
	-- 9731
	if SkillJudger:IsTypeOf(self, caster, target, true,4) then
	else
		return
	end
	-- 60000074
	self:AddTempAttr(SkillEffect[60000074], caster, self.card, data, "damage2",0.5)
end
-- 入场时
function Skill6000010:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 60000075
	self:AddBuff(SkillEffect[60000075], caster, self.card, data, 60000075)
end
