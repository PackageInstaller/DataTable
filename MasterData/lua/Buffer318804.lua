-- 耐久上限強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer318804 = oo.class(BuffBase)
function Buffer318804:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer318804:OnCreate(caster, target)
	-- 318804
	self:AddMaxHpPercent(BufferEffect[318804], self.caster, target or self.owner, nil,0.16)
end
