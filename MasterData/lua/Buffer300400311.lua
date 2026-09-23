-- 引導標識
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer300400311 = oo.class(BuffBase)
function Buffer300400311:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer300400311:OnBefourHurt(caster, target)
	-- 8064
	if SkillJudger:CasterIsSummon(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 300400311
	self:AddTempAttr(BufferEffect[300400311], self.caster, self.card, nil, "bedamage",0.12*self.nCount)
end
