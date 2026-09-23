-- 傷害提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330705 = oo.class(BuffBase)
function Buffer330705:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer330705:OnCreate(caster, target)
	-- 330705
	self:AddAttr(BufferEffect[330705], self.caster, target or self.owner, nil,"crit",0.15)
end
