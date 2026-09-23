-- 山脈機制buff2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101703 = oo.class(BuffBase)
function Buffer980101703:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101703:OnCreate(caster, target)
	-- 8746
	local c142 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,7)
	-- 980101703
	self:AddAttr(BufferEffect[980101703], self.caster, target or self.owner, nil,"damage",0.02*c142)
end
