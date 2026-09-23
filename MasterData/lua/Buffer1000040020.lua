-- 群體能量傷害增加20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040020 = oo.class(BuffBase)
function Buffer1000040020:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000040020:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsDamageType(self, self.caster, target, true,2) then
	else
		return
	end
	-- 8203
	if SkillJudger:IsSingle(self, self.caster, target, false) then
	else
		return
	end
	-- 1000040020
	self:AddTempAttrPercent(BufferEffect[1000040020], self.caster, self.card, nil, "damage",0.3)
end
