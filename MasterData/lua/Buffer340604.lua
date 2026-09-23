-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340604 = oo.class(BuffBase)
function Buffer340604:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340604:OnCreate(caster, target)
	-- 340604
	self:AddAttrPercent(BufferEffect[340604], self.caster, self.card, nil, "attack",0.4)
	-- 340609
	self:AddAttr(BufferEffect[340609], self.caster, self.card, nil, "bedamage",0.8)
	-- 340614
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[340614], self.caster, target, nil, "bedamage",-0.4)
	end
end
