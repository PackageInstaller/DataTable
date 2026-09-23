-- 朱炎之印
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704400101 = oo.class(BuffBase)
function Buffer704400101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704400101:OnCreate(caster, target)
	-- 8761
	local c761 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,47044)
	-- 704400101
	self:AddAttrPercent(BufferEffect[704400101], self.caster, self.card, nil, "attack",(0.03+c761/100)*self.nCount)
	-- 8761
	local c761 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,47044)
	-- 704400102
	self:AddAttrPercent(BufferEffect[704400102], self.caster, self.card, nil, "defense",(0.03+c761/100)*self.nCount)
end
