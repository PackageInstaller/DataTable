-- 共鳴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer702600203 = oo.class(BuffBase)
function Buffer702600203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer702600203:OnCreate(caster, target)
	-- 702600203
	self:AddAttrPercent(BufferEffect[702600203], self.caster, self.card, nil, "defense",0.8)
	-- 702600213
	self:AddAttr(BufferEffect[702600213], self.caster, self.card, nil, "crit_rate",0.5)
end
