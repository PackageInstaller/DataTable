-- 連鎖強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4603002 = oo.class(BuffBase)
function Buffer4603002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4603002:OnCreate(caster, target)
	-- 8468
	local c68 = SkillApi:GetDamage(self, self.caster, target or self.owner,3)
	-- 4603032
	self:AddAttr(BufferEffect[4603032], self.caster, self.card, nil, "attack",math.floor(math.min(c68*0.01,1000)))
	-- 8468
	local c68 = SkillApi:GetDamage(self, self.caster, target or self.owner,3)
	-- 4603042
	self:AddAttr(BufferEffect[4603042], self.caster, self.creater, nil, "attack",math.floor(math.min(c68*0.01,1000)))
end
