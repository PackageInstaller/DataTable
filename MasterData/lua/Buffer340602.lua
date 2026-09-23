-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340602 = oo.class(BuffBase)
function Buffer340602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340602:OnCreate(caster, target)
	-- 340602
	self:AddAttrPercent(BufferEffect[340602], self.caster, self.card, nil, "attack",0.2)
	-- 340607
	self:AddAttr(BufferEffect[340607], self.caster, self.card, nil, "bedamage",0.4)
	-- 340612
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[340612], self.caster, target, nil, "bedamage",-0.2)
	end
end
