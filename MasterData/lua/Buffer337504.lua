-- 暴擊增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337504 = oo.class(BuffBase)
function Buffer337504:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337504:OnCreate(caster, target)
	-- 337504
	self:AddAttr(BufferEffect[337504], self.caster, target or self.owner, nil,"crit_rate",0.08)
end
