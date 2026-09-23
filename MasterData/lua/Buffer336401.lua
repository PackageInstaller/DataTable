-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer336401 = oo.class(BuffBase)
function Buffer336401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer336401:OnCreate(caster, target)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 336401
	self:AddAttr(BufferEffect[336401], self.caster, self.creater, nil, "attack",c15*0.03)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 336406
	self:AddAttr(BufferEffect[336406], self.caster, self.card, nil, "attack",c15*-0.03)
end
