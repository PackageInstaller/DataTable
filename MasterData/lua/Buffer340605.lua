-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340605 = oo.class(BuffBase)
function Buffer340605:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340605:OnCreate(caster, target)
	-- 340605
	self:AddAttrPercent(BufferEffect[340605], self.caster, self.card, nil, "attack",0.5)
	-- 340610
	self:AddAttr(BufferEffect[340610], self.caster, self.card, nil, "bedamage",1)
	-- 340615
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[340615], self.caster, target, nil, "bedamage",-0.5)
	end
end
