-- 榮耀之心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4100104 = oo.class(BuffBase)
function Buffer4100104:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4100104:OnCreate(caster, target)
	-- 4100104
	self:AddAttrPercent(BufferEffect[4100104], self.caster, target or self.owner, nil,"attack",0.25*self.nCount)
	-- 4100114
	self:AddAttrPercent(BufferEffect[4100114], self.caster, target or self.owner, nil,"defense",0.25*self.nCount)
	-- 4100124
	self:AddAttr(BufferEffect[4100124], self.caster, target or self.owner, nil,"resist",0.25*self.nCount)
end
