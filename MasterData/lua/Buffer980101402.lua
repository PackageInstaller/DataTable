-- 山脈機制buff2效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101402 = oo.class(BuffBase)
function Buffer980101402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101402:OnCreate(caster, target)
	-- 8743
	local c139 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,4)
	-- 980101402
	self:AddAttr(BufferEffect[980101402], self.caster, target or self.owner, nil,"speed",2*c139)
	-- 8743
	local c139 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,4)
	-- 980101403
	self:AddAttr(BufferEffect[980101403], self.caster, target or self.owner, nil,"attack",0.05*c139)
end
