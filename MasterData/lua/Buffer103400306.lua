-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103400306 = oo.class(BuffBase)
function Buffer103400306:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103400306:OnCreate(caster, target)
	-- 103400313
	self:AddAttr(BufferEffect[103400313], self.caster, self.card, nil, "crit_rate",-0.10)
	-- 103400308
	self:AddAttr(BufferEffect[103400308], self.caster, self.card, nil, "crit",0.10)
end
