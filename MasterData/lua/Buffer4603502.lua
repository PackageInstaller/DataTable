-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4603502 = oo.class(BuffBase)
function Buffer4603502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4603502:OnCreate(caster, target)
	-- 4603502
	local c6035 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,46035)
	-- 4603503
	local c603503 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hit")
	-- 4603504
	self:AddAttr(BufferEffect[4603504], self.caster, self.card, nil, "attack",c6035*3*c603503*100)
end
