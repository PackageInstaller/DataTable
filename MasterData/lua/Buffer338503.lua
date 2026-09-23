-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer338503 = oo.class(BuffBase)
function Buffer338503:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer338503:OnCreate(caster, target)
	-- 8442
	local c42 = SkillApi:GetCureHp(self, self.caster, target or self.owner,2)
	-- 338503
	self:AddAttr(BufferEffect[338503], self.caster, self.card, nil, "attack",math.min(c42*0.20,1000))
end
