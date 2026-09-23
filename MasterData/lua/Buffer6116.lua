-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6116 = oo.class(BuffBase)
function Buffer6116:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer6116:OnBefourHurt(caster, target)
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
	-- 8203
	if SkillJudger:IsSingle(self, self.caster, target, false) then
	else
		return
	end
	-- 4917
	if SkillJudger:HasRole(self, self.caster, self.card, true,1,70030) then
	else
		return
	end
	-- 4916
	self:AddTempAttr(BufferEffect[4916], self.caster, self.card, nil, "bedamage",-0.3)
end
