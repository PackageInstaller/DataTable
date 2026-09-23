-- 耐久上限減少
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932800202 = oo.class(BuffBase)
function Buffer932800202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932800202:OnCreate(caster, target)
	-- 8475
	local c75 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"attack")
	-- 932800202
	self:AddMaxHpPercent(BufferEffect[932800202], self.caster, self.card, nil, -0.1,-c75*10)
end
