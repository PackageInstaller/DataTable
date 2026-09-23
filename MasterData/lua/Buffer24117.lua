-- 震懾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24117 = oo.class(BuffBase)
function Buffer24117:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer24117:OnRoundBegin(caster, target)
	-- 24177
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24177], self.caster, target, nil, 24135)
	end
end
-- 创建时
function Buffer24117:OnCreate(caster, target)
	-- 24177
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24177], self.caster, target, nil, 24135)
	end
end
