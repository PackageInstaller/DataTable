-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800106 = oo.class(BuffBase)
function Buffer5800106:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5800106:OnCreate(caster, target)
	-- 5800106
	self:AddAttr(BufferEffect[5800106], self.caster, self.card, nil, "attack",200*self.nCount)
end
