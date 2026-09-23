-- 暴傷轉化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328503 = oo.class(BuffBase)
function Buffer328503:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328503:OnCreate(caster, target)
	-- 8476
	local c76 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit_rate")
	-- 328503
	self:AddAttr(BufferEffect[328503], self.caster, target or self.owner, nil,"crit",math.max((c76-1)*1.3,0))
end
