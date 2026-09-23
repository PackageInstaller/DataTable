-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103400308 = oo.class(BuffBase)
function Buffer103400308:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103400308:OnCreate(caster, target)
	-- 103400315
	self:AddAttr(BufferEffect[103400315], self.caster, self.card, nil, "crit_rate",-0.20)
	-- 103400310
	self:AddAttr(BufferEffect[103400310], self.caster, self.card, nil, "crit",0.20)
end
