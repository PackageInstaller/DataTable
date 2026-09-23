-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24813 = oo.class(BuffBase)
function Buffer24813:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24813:OnCreate()
	local c5 = SkillApi:PercentHp(self, self.caster, target or self.owner,3)
	self:AddAttrPercent(BufferEffect[24813], self.caster, self.card, nil, "attack",0.36)
end
