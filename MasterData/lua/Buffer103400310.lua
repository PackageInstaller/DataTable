-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103400310 = oo.class(BuffBase)
function Buffer103400310:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103400310:OnCreate(caster, target)
	-- 103400317
	self:AddAttr(BufferEffect[103400317], self.caster, self.card, nil, "crit_rate",-0.30)
	-- 103400312
	self:AddAttr(BufferEffect[103400312], self.caster, self.card, nil, "crit",0.30)
end
