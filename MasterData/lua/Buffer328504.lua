-- 暴傷轉化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328504 = oo.class(BuffBase)
function Buffer328504:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328504:OnCreate(caster, target)
	-- 8476
	local c76 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit_rate")
	-- 328504
	self:AddAttr(BufferEffect[328504], self.caster, target or self.owner, nil,"crit",math.max((c76-1)*1.4,0))
end
