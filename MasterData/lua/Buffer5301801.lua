-- 狂獵
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5301801 = oo.class(BuffBase)
function Buffer5301801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5301801:OnCreate(caster, target)
	-- 5301801
	self:AddAttr(BufferEffect[5301801], self.caster, self.card, nil, "attack",200*self.nCount)
	-- 8785
	local c785 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,43018)
	-- 5301802
	self:AddAttr(BufferEffect[5301802], self.caster, self.card, nil, "crit",0.01*self.nCount*(c785+1))
end
