-- 外殼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932900704 = oo.class(BuffBase)
function Buffer932900704:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 暴击伤害前(OnBefourHurt之前)
function Buffer932900704:OnBefourCritHurt(caster, target)
	-- 932900711
	self:AddTempAttr(BufferEffect[932900711], self.caster, self.card, nil, "bedamage2",0.5)
end
