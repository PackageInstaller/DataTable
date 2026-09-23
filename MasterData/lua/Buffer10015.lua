-- 機神強化-等級6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10015 = oo.class(BuffBase)
function Buffer10015:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10015:OnCreate(caster, target)
	-- 4024
	self:AddAttrPercent(BufferEffect[4024], self.caster, target or self.owner, nil,"attack",0.3)
end
