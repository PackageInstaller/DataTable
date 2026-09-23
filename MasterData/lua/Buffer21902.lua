-- 攻擊和命中提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer21902 = oo.class(BuffBase)
function Buffer21902:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer21902:OnCreate(caster, target)
	-- 21902
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[21902], self.caster, target, nil, "attack",0.10)
	end
	-- 21912
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[21912], self.caster, target, nil, "hit",0.10)
	end
end
