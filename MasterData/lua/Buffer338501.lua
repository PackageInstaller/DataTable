-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer338501 = oo.class(BuffBase)
function Buffer338501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer338501:OnCreate(caster, target)
	-- 8442
	local c42 = SkillApi:GetCureHp(self, self.caster, target or self.owner,2)
	-- 338501
	self:AddAttr(BufferEffect[338501], self.caster, self.card, nil, "attack",math.min(c42*0.1,600))
end
