-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer336404 = oo.class(BuffBase)
function Buffer336404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer336404:OnCreate(caster, target)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 336404
	self:AddAttr(BufferEffect[336404], self.caster, self.creater, nil, "attack",c15*0.12)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 336409
	self:AddAttr(BufferEffect[336409], self.caster, self.card, nil, "attack",c15*-0.12)
end
