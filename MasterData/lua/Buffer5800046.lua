-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800046 = oo.class(BuffBase)
function Buffer5800046:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer5800046:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5800046
	self:AddTempAttrPercent(BufferEffect[5800046], self.caster, self.caster, nil, "attack",math.randbetween(1,100))
end
