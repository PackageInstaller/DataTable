-- 突擊形態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4922911 = oo.class(BuffBase)
function Buffer4922911:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4922911:OnCreate(caster, target)
	-- 4008
	self:AddAttrPercent(BufferEffect[4008], self.caster, target or self.owner, nil,"attack",0.4)
	-- 5204
	self:AddAttr(BufferEffect[5204], self.caster, target or self.owner, nil,"speed",-20)
end
