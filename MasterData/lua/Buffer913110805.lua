-- 1個強化效果,爆傷20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913110805 = oo.class(BuffBase)
function Buffer913110805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913110805:OnCreate(caster, target)
	-- 913110805
	self:AddAttr(BufferEffect[913110805], self.caster, self.card, nil, "crit",0.2)
end
