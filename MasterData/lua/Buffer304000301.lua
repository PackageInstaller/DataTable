-- 精神摧毀
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer304000301 = oo.class(BuffBase)
function Buffer304000301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer304000301:OnCreate(caster, target)
	-- 5002
	self:AddAttrPercent(BufferEffect[5002], self.caster, target or self.owner, nil,"attack",-0.1)
	-- 5102
	self:AddAttrPercent(BufferEffect[5102], self.caster, target or self.owner, nil,"defense",-0.1)
	-- 8474
	local c74 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,43040)
	-- 304000301
	self:AddAttr(BufferEffect[304000301], self.caster, self.card, nil, "bedamage",0.01*c74)
end
