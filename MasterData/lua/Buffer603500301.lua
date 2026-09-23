-- 正義看破
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603500301 = oo.class(BuffBase)
function Buffer603500301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603500301:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 603500301
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500301], self.caster, target, nil, "LimitDamage1003",0.10)
	end
	-- 603500311
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500311], self.caster, target, nil, "LimitDamage1001",0.10)
	end
	-- 603500321
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500321], self.caster, target, nil, "LimitDamage1002",0.10)
	end
	-- 603500331
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddValue(BufferEffect[603500331], self.caster, target, nil, "LimitDamage1051",0.10)
	end
end
