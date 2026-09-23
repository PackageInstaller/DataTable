-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24812 = oo.class(BuffBase)
function Buffer24812:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24812:OnCreate()
	local c5 = SkillApi:PercentHp(self, self.caster, target or self.owner,3)
	self:AddAttrPercent(BufferEffect[24812], self.caster, self.card, nil, "attack",0.24)
end
