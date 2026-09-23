-- 攻擊增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932800203 = oo.class(BuffBase)
function Buffer932800203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932800203:OnCreate(caster, target)
	-- 932800204
	local cmaxhp = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"maxhp")
	-- 932800203
	self:AddAttr(BufferEffect[932800203], self.caster, self.card, nil, "attack",math.max(math.min((cmaxhp-18000), 4000), 0))
end
