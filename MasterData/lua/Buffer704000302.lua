-- 綻放
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704000302 = oo.class(BuffBase)
function Buffer704000302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704000302:OnCreate(caster, target)
	-- 4002
	self:AddAttrPercent(BufferEffect[4002], self.caster, target or self.owner, nil,"attack",0.1)
	-- 4301
	self:AddAttr(BufferEffect[4301], self.caster, target or self.owner, nil,"crit_rate",0.05)
end
