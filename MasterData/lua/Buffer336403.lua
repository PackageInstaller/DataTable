-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer336403 = oo.class(BuffBase)
function Buffer336403:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer336403:OnCreate(caster, target)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 336403
	self:AddAttr(BufferEffect[336403], self.caster, self.creater, nil, "attack",c15*0.09)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 336408
	self:AddAttr(BufferEffect[336408], self.caster, self.card, nil, "attack",c15*-0.09)
end
