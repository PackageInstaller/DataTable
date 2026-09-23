-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6400009 = oo.class(BuffBase)
function Buffer6400009:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6400009:OnCreate(caster, target)
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
	-- 8225
	if SkillJudger:IsTypeOf(self, self.caster, target, true,4) then
	else
		return
	end
	-- 4314
	self:AddTempAttr(BufferEffect[4314], self.caster, self.card, nil, "crit_rate",0.1)
	-- 4402
	self:AddAttr(BufferEffect[4402], self.caster, target or self.owner, nil,"crit",0.1)
	-- 1100010146
	self:AddMaxHp(BufferEffect[1100010146], self.caster, self.card, nil, 1000000)
end
