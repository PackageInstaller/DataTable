-- 暴發
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer325702 = oo.class(BuffBase)
function Buffer325702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer325702:OnCreate(caster, target)
	-- 325701
	self:AddAttr(BufferEffect[325701], self.caster, target or self.owner, nil,"crit_rate",0.10)
	-- 325712
	self:AddAttr(BufferEffect[325712], self.caster, target or self.owner, nil,"crit",0.20)
end
