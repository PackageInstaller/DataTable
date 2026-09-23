-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24811 = oo.class(BuffBase)
function Buffer24811:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24811:OnCreate()
	local c5 = SkillApi:PercentHp(self, self.caster, target or self.owner,3)
	self:AddAttrPercent(BufferEffect[24811], self.caster, self.card, nil, "attack",0.12)
end
