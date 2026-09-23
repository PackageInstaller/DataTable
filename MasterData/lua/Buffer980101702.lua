-- 山脈機制buff2效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101702 = oo.class(BuffBase)
function Buffer980101702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101702:OnCreate(caster, target)
	-- 8746
	local c142 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,7)
	-- 980101702
	self:AddAttr(BufferEffect[980101702], self.caster, target or self.owner, nil,"crit",0.1*c142)
end
