-- 山脈機制buff2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101603 = oo.class(BuffBase)
function Buffer980101603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101603:OnCreate(caster, target)
	-- 8745
	local c141 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,6)
	-- 980101603
	self:AddAttr(BufferEffect[980101603], self.caster, target or self.owner, nil,"attack",0.05*c139)
end
