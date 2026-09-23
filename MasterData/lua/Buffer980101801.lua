-- 山脈屬性buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101801 = oo.class(BuffBase)
function Buffer980101801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101801:OnCreate(caster, target)
	-- 8756
	local c152 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,8)
	-- 980101801
	self:AddAttrPercent(BufferEffect[980101801], self.caster, target or self.owner, nil,"attack",1)
	-- 8756
	local c152 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,8)
	-- 980101802
	self:AddAttr(BufferEffect[980101802], self.caster, target or self.owner, nil,"crit",1)
	-- 8756
	local c152 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,8)
	-- 980101803
	self:AddAttr(BufferEffect[980101803], self.caster, target or self.owner, nil,"damage",1)
	-- 8756
	local c152 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,8)
	-- 980101804
	self:AddAttr(BufferEffect[980101804], self.caster, target or self.owner, nil,"bedamage",-0.5)
end
