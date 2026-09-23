-- 對【易傷】目標造成額外30%傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040090 = oo.class(BuffBase)
function Buffer1000040090:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1000040090:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8260
	if SkillJudger:IsCanHurt(self, self.caster, target, false) then
	else
		return
	end
	-- 1000040090
	self:AddAttrPercent(BufferEffect[1000040090], self.caster, self.card, nil, "damage",0.15)
end
