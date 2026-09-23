-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337904 = oo.class(BuffBase)
function Buffer337904:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337904:OnCreate(caster, target)
	-- 337904
	self:AddAttr(BufferEffect[337904], self.caster, target or self.owner, nil,"hit",-0.25)
end
