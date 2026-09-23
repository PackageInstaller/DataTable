-- 狂暴狀態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4906105 = oo.class(BuffBase)
function Buffer4906105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4906105:OnCreate(caster, target)
	-- 4016
	self:AddAttrPercent(BufferEffect[4016], self.caster, target or self.owner, nil,"attack",0.80)
	-- 4116
	self:AddAttrPercent(BufferEffect[4116], self.caster, target or self.owner, nil,"defense",0.8)
	-- 4212
	self:AddAttr(BufferEffect[4212], self.caster, target or self.owner, nil,"speed",60)
end
