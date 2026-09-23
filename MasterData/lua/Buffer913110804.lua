-- 1個強化效果,暴擊10%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913110804 = oo.class(BuffBase)
function Buffer913110804:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913110804:OnCreate(caster, target)
	-- 913110804
	self:AddAttr(BufferEffect[913110804], self.caster, self.card, nil, "crit_rate",0.1)
end
