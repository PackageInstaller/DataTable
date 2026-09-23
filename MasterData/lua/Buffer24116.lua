-- 震懾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24116 = oo.class(BuffBase)
function Buffer24116:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer24116:OnRoundBegin(caster, target)
	-- 24176
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24176], self.caster, target, nil, 24134)
	end
end
-- 创建时
function Buffer24116:OnCreate(caster, target)
	-- 24176
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24176], self.caster, target, nil, 24134)
	end
end
