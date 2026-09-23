-- 傷害提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330704 = oo.class(BuffBase)
function Buffer330704:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer330704:OnCreate(caster, target)
	-- 330704
	self:AddAttr(BufferEffect[330704], self.caster, target or self.owner, nil,"crit",0.12)
end
