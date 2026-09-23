-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340601 = oo.class(BuffBase)
function Buffer340601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340601:OnCreate(caster, target)
	-- 340601
	self:AddAttrPercent(BufferEffect[340601], self.caster, self.card, nil, "attack",0.1)
	-- 340606
	self:AddAttr(BufferEffect[340606], self.caster, self.card, nil, "bedamage",0.2)
	-- 340611
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[340611], self.caster, target, nil, "bedamage",-0.1)
	end
end
