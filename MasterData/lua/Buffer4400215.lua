-- 約束傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400215 = oo.class(BuffBase)
function Buffer4400215:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400215:OnCreate(caster, target)
	-- 8498
	local c98 = SkillApi:GetCount(self, self.caster, target or self.owner,4,4400205)
	-- 4400215
	self:LimitDamage(BufferEffect[4400215], self.caster, target or self.owner, nil,1,0.25*c98)
end
