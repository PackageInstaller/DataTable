-- 暴發
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer325705 = oo.class(BuffBase)
function Buffer325705:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer325705:OnCreate(caster, target)
	-- 325703
	self:AddAttr(BufferEffect[325703], self.caster, target or self.owner, nil,"crit_rate",0.20)
	-- 325713
	self:AddAttr(BufferEffect[325713], self.caster, target or self.owner, nil,"crit",0.30)
end
