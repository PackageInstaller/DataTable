-- 共鳴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer702600201 = oo.class(BuffBase)
function Buffer702600201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer702600201:OnCreate(caster, target)
	-- 702600201
	self:AddAttrPercent(BufferEffect[702600201], self.caster, self.card, nil, "defense",0.6)
	-- 702600211
	self:AddAttr(BufferEffect[702600211], self.caster, self.card, nil, "crit_rate",0.3)
end
