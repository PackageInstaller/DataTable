-- 1個強化效果,效果命中30%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913110806 = oo.class(BuffBase)
function Buffer913110806:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913110806:OnCreate(caster, target)
	-- 913110806
	self:AddAttr(BufferEffect[913110806], self.caster, self.card, nil, "hit",0.3)
end
