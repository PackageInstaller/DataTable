-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer600800201 = oo.class(BuffBase)
function Buffer600800201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer600800201:OnBefourHurt(caster, target)
	-- 8401
	local c1 = SkillApi:GetAttr(self, self.caster, target or self.owner,2,"attack")
	-- 8515
	self:AddAttr(BufferEffect[8515], self.caster, self.caster, nil, "attack",c1*0.3)
end
