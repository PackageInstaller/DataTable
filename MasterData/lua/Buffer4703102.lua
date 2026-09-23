-- 餘暉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4703102 = oo.class(BuffBase)
function Buffer4703102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4703102:OnCreate(caster, target)
	-- 8499
	local c99 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,47031)
	-- 4703102
	self:AddAttr(BufferEffect[4703102], self.caster, self.card, nil, "damage",(0.02*c99)*self.nCount)
end
