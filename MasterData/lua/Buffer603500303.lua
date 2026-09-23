-- 正義看破
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603500303 = oo.class(BuffBase)
function Buffer603500303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603500303:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 603500303
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500303], self.caster, target, nil, "LimitDamage1003",0.30)
	end
	-- 603500313
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500313], self.caster, target, nil, "LimitDamage1001",0.30)
	end
	-- 603500323
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500323], self.caster, target, nil, "LimitDamage1002",0.30)
	end
	-- 603500333
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500333], self.caster, target, nil, "LimitDamage1051",0.30)
	end
end
