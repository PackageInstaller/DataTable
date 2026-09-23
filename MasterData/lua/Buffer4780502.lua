-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4780502 = oo.class(BuffBase)
function Buffer4780502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4780502:OnCreate(caster, target)
	-- 8419
	local c19 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit_rate")
	-- 8771
	local c771 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit")
	-- 4780502
	self:AddAttr(BufferEffect[4780502], self.caster, self.card, nil, "attack",math.floor(c19*100*75))
	-- 8419
	local c19 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit_rate")
	-- 8771
	local c771 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit")
	-- 4780507
	self:AddAttr(BufferEffect[4780507], self.caster, self.card, nil, "damage2",(c771-1)*0.75)
end
