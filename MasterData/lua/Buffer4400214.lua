-- 約束傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400214 = oo.class(BuffBase)
function Buffer4400214:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400214:OnCreate(caster, target)
	-- 8497
	local c97 = SkillApi:GetCount(self, self.caster, target or self.owner,4,4400204)
	-- 4400214
	self:LimitDamage(BufferEffect[4400214], self.caster, target or self.owner, nil,1,0.20*c97)
end
