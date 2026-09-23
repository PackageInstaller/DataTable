-- 受修復效果提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23203 = oo.class(BuffBase)
function Buffer23203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer23203:OnCreate(caster, target)
	-- 22003
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[22003], self.caster, target, nil, "resist",0.15)
	end
end
