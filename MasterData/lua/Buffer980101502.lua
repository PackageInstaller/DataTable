-- 山脈機制buff2效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101502 = oo.class(BuffBase)
function Buffer980101502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101502:OnCreate(caster, target)
	-- 8744
	local c140 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,5)
	-- 980101502
	self:AddAttr(BufferEffect[980101502], self.caster, target or self.owner, nil,"attack",50*c140)
end
