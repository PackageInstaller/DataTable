-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800051 = oo.class(BuffBase)
function Buffer5800051:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer5800051:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5800051
	self:AddTempAttrPercent(BufferEffect[5800051], self.caster, self.card, nil, "attack",1,5,100)
end
