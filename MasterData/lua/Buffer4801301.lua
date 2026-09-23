-- 軍團領域
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4801301 = oo.class(BuffBase)
function Buffer4801301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4801301:OnCreate(caster, target)
	-- 4801301
	self:AddAttr(BufferEffect[4801301], self.caster, target or self.owner, nil,"crit_rate",0.1)
	-- 4801302
	self:AddAttrPercent(BufferEffect[4801302], self.caster, target or self.owner, nil,"defense",0.15)
	-- 4801303
	self:AddAttrPercent(BufferEffect[4801303], self.caster, target or self.owner, nil,"attack",0.15)
end
