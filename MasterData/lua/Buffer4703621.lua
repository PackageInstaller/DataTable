-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4703621 = oo.class(BuffBase)
function Buffer4703621:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4703621:OnCreate(caster, target)
	-- 4703621
	self:AddMaxHpPercent(BufferEffect[4703621], self.caster, target or self.owner, nil,0.03)
end
