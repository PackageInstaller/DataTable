-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer933800301 = oo.class(BuffBase)
function Buffer933800301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer933800301:OnBefourHurt(caster, target)
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
	-- 933800301
	self:AddTempAttr(BufferEffect[933800301], self.caster, target or self.owner, nil,"bedamage2",-0.2)
end
