-- 耐久上限強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer318805 = oo.class(BuffBase)
function Buffer318805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer318805:OnCreate(caster, target)
	-- 318805
	self:AddMaxHpPercent(BufferEffect[318805], self.caster, target or self.owner, nil,0.20)
end
