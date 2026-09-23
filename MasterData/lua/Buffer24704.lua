-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24704 = oo.class(BuffBase)
function Buffer24704:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24704:OnCreate(caster, target)
	-- 8405
	local c5 = SkillApi:PercentHp(self, self.caster, target or self.owner,3)
	-- 24704
	self:AddAttrPercent(BufferEffect[24704], self.caster, self.card, nil, "attack",math.floor((1-c5)*100)*0.004)
end
