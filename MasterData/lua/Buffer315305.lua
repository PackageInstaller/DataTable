-- 耐久上限強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer315305 = oo.class(BuffBase)
function Buffer315305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer315305:OnCreate(caster, target)
	-- 315305
	self:AddMaxHpPercent(BufferEffect[315305], self.caster, target or self.owner, nil,0.05)
end
