-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4703624 = oo.class(BuffBase)
function Buffer4703624:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4703624:OnCreate(caster, target)
	-- 4703624
	self:AddMaxHpPercent(BufferEffect[4703624], self.caster, target or self.owner, nil,0.12)
end
