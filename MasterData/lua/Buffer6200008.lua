-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6200008 = oo.class(BuffBase)
function Buffer6200008:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6200008:OnCreate(caster, target)
	-- 6200008
	self:AddShieldValue(BufferEffect[6200008], self.caster, self.card, nil, 1000000)
end
