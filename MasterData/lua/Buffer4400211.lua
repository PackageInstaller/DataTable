-- 约束伤害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400211 = oo.class(BuffBase)
function Buffer4400211:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400211:OnCreate(caster, target)
	-- 8490
	local c90 = SkillApi:GetCount(self, self.caster, target or self.owner,4,4400201)
	-- 4400211
	self:LimitDamage(BufferEffect[4400211], self.caster, target or self.owner, nil,1,0.15*c90)
end
