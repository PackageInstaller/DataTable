-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer336405 = oo.class(BuffBase)
function Buffer336405:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer336405:OnCreate(caster, target)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 336405
	self:AddAttr(BufferEffect[336405], self.caster, self.creater, nil, "attack",c15*0.15)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 336410
	self:AddAttr(BufferEffect[336410], self.caster, self.card, nil, "attack",c15*-0.15)
end
