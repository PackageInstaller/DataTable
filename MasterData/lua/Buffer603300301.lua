-- 黃金統御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603300301 = oo.class(BuffBase)
function Buffer603300301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603300301:OnCreate(caster, target)
	-- 603300301
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(BufferEffect[603300301], self.caster, target, nil, 603300302)
	end
end
