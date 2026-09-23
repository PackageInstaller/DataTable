-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337902 = oo.class(BuffBase)
function Buffer337902:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337902:OnCreate(caster, target)
	-- 337902
	self:AddAttr(BufferEffect[337902], self.caster, target or self.owner, nil,"hit",-0.15)
end
