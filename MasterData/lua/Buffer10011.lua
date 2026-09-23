-- 機神強化-等級2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10011 = oo.class(BuffBase)
function Buffer10011:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10011:OnCreate(caster, target)
	-- 4020
	self:AddAttrPercent(BufferEffect[4020], self.caster, target or self.owner, nil,"attack",0.1)
end
