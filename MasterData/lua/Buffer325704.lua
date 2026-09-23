-- 暴發
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer325704 = oo.class(BuffBase)
function Buffer325704:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer325704:OnCreate(caster, target)
	-- 325702
	self:AddAttr(BufferEffect[325702], self.caster, target or self.owner, nil,"crit_rate",0.15)
	-- 325713
	self:AddAttr(BufferEffect[325713], self.caster, target or self.owner, nil,"crit",0.30)
end
