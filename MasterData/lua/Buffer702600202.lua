-- 共鳴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer702600202 = oo.class(BuffBase)
function Buffer702600202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer702600202:OnCreate(caster, target)
	-- 702600202
	self:AddAttrPercent(BufferEffect[702600202], self.caster, self.card, nil, "defense",0.7)
	-- 702600212
	self:AddAttr(BufferEffect[702600212], self.caster, self.card, nil, "crit_rate",0.4)
end
