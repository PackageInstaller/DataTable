-- 反擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer102300310 = oo.class(BuffBase)
function Buffer102300310:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer102300310:OnCreate(caster, target)
	-- 102300310
	self:AddAttrPercent(BufferEffect[102300310], self.caster, self.card, nil, "attack",0.5*self.nCount)
end
