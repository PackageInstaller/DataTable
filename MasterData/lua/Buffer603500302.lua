-- 正義看破
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603500302 = oo.class(BuffBase)
function Buffer603500302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603500302:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 603500302
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500302], self.caster, target, nil, "LimitDamage1003",0.20)
	end
	-- 603500312
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500312], self.caster, target, nil, "LimitDamage1001",0.20)
	end
	-- 603500322
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500322], self.caster, target, nil, "LimitDamage1002",0.20)
	end
	-- 603500332
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500332], self.caster, target, nil, "LimitDamage1051",0.20)
	end
end
