-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334504 = oo.class(BuffBase)
function Buffer334504:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer334504:OnCreate(caster, target)
	-- 4601504
	self:AddAttr(BufferEffect[4601504], self.caster, self.card, nil, "attack",120*self.nCount)
end
