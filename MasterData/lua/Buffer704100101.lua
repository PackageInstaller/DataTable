-- 心眼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704100101 = oo.class(BuffBase)
function Buffer704100101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704100101:OnCreate(caster, target)
	-- 8759
	local c759 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,47041)
	-- 704100101
	self:AddAttr(BufferEffect[704100101], self.caster, self.card, nil, "crit",(0.03+0.01*c759)*self.nCount)
	-- 8759
	local c759 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,47041)
	-- 704100102
	self:AddAttr(BufferEffect[704100102], self.caster, self.card, nil, "bedamage",-(0.1*c759))
end
