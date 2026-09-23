-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5500120 = oo.class(BuffBase)
function Buffer5500120:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5500120:OnCreate(caster, target)
	-- 4507
	self:AddAttr(BufferEffect[4507], self.caster, target or self.owner, nil,"hit",0.5)
	-- 4609
	self:AddAttr(BufferEffect[4609], self.caster, target or self.owner, nil,"resist",0.5)
end
