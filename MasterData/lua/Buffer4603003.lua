-- 連鎖強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4603003 = oo.class(BuffBase)
function Buffer4603003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4603003:OnCreate(caster, target)
	-- 8468
	local c68 = SkillApi:GetDamage(self, self.caster, target or self.owner,3)
	-- 4603033
	self:AddAttr(BufferEffect[4603033], self.caster, self.card, nil, "attack",math.floor(math.min(c68*0.02,1500)))
	-- 8468
	local c68 = SkillApi:GetDamage(self, self.caster, target or self.owner,3)
	-- 4603043
	self:AddAttr(BufferEffect[4603043], self.caster, self.creater, nil, "attack",math.floor(math.min(c68*0.02,1500)))
end
