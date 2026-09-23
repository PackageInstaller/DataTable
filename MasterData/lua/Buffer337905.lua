-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337905 = oo.class(BuffBase)
function Buffer337905:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337905:OnCreate(caster, target)
	-- 337905
	self:AddAttr(BufferEffect[337905], self.caster, target or self.owner, nil,"hit",-0.30)
end
