-- 角色每損失1%生命值，傷害提高0.8%，最高100%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030140 = oo.class(BuffBase)
function Buffer1000030140:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000030140:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8705
	local c101 = SkillApi:PercentHp(self, self.caster, target or self.owner,1)
	-- 1000030140
	self:AddTempAttr(BufferEffect[1000030140], self.caster, self.card, nil, "damage",math.min((1-c101)*0.8,1))
end
