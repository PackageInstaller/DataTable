-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer338504 = oo.class(BuffBase)
function Buffer338504:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer338504:OnCreate(caster, target)
	-- 8442
	local c42 = SkillApi:GetCureHp(self, self.caster, target or self.owner,2)
	-- 338504
	self:AddAttr(BufferEffect[338504], self.caster, self.card, nil, "attack",math.min(c42*0.25,1200))
end
