-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24701 = oo.class(BuffBase)
function Buffer24701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24701:OnCreate(caster, target)
	-- 8405
	local c5 = SkillApi:PercentHp(self, self.caster, target or self.owner,3)
	-- 24701
	self:AddAttrPercent(BufferEffect[24701], self.caster, self.card, nil, "attack",math.floor((1-c5)*10)*0.02)
end
