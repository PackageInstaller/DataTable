-- 山脈屬性buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101601 = oo.class(BuffBase)
function Buffer980101601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101601:OnCreate(caster, target)
	-- 8745
	local c141 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,6)
	-- 980101601
	self:AddAttrPercent(BufferEffect[980101601], self.caster, target or self.owner, nil,"attack",0.08*c141)
end
