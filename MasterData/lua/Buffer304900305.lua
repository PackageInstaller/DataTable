-- 潮汐標記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer304900305 = oo.class(BuffBase)
function Buffer304900305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer304900305:OnCreate(caster, target)
	-- 4003
	self:AddAttrPercent(BufferEffect[4003], self.caster, target or self.owner, nil,"attack",0.15)
	-- 4303
	self:AddAttr(BufferEffect[4303], self.caster, target or self.owner, nil,"crit_rate",0.15)
end
