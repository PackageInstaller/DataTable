-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer336402 = oo.class(BuffBase)
function Buffer336402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer336402:OnCreate(caster, target)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 336402
	self:AddAttr(BufferEffect[336402], self.caster, self.creater, nil, "attack",c15*0.06)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 336407
	self:AddAttr(BufferEffect[336407], self.caster, self.card, nil, "attack",c15*-0.06)
end
