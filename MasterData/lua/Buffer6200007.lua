-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6200007 = oo.class(BuffBase)
function Buffer6200007:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6200007:OnCreate(caster, target)
	-- 6200007
	self:AddShieldValue(BufferEffect[6200007], self.caster, self.card, nil, 500000)
end
